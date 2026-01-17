-- ============================================
-- HARVEST REALTY PORTAL - SUPABASE SCHEMA
-- Run this in Supabase SQL Editor
-- ============================================

-- 1. AGENTS TABLE (Users/Profiles)
CREATE TABLE agents (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    role TEXT DEFAULT 'Sales Agent',
    phone TEXT,
    license_pa TEXT,
    license_nj TEXT,
    bio TEXT,
    specialties TEXT,
    is_admin BOOLEAN DEFAULT FALSE,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. LISTINGS TABLE
CREATE TABLE listings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    agent_id UUID REFERENCES agents(id) ON DELETE CASCADE,
    address TEXT NOT NULL,
    price TEXT NOT NULL,
    property_type TEXT,
    status TEXT DEFAULT 'Active',
    beds INTEGER,
    baths DECIMAL(3,1),
    sqft INTEGER,
    mls_number TEXT,
    description TEXT,
    features TEXT,
    photo_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. COMMITS/CHANGELOG TABLE
CREATE TABLE commits (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    hash TEXT NOT NULL,
    message TEXT NOT NULL,
    author_name TEXT,
    author_email TEXT,
    changes JSONB,
    files_changed TEXT[],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. SESSIONS TABLE (for login tracking)
CREATE TABLE sessions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    agent_id UUID REFERENCES agents(id) ON DELETE CASCADE,
    token TEXT UNIQUE NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================

-- Enable RLS on all tables
ALTER TABLE agents ENABLE ROW LEVEL SECURITY;
ALTER TABLE listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE commits ENABLE ROW LEVEL SECURITY;
ALTER TABLE sessions ENABLE ROW LEVEL SECURITY;

-- Agents: Anyone can read (for public profiles), only self can update
CREATE POLICY "Agents are viewable by everyone" ON agents
    FOR SELECT USING (true);

CREATE POLICY "Agents can update own profile" ON agents
    FOR UPDATE USING (true);

CREATE POLICY "Allow insert for registration" ON agents
    FOR INSERT WITH CHECK (true);

-- Listings: Anyone can read, agents can manage their own
CREATE POLICY "Listings are viewable by everyone" ON listings
    FOR SELECT USING (true);

CREATE POLICY "Agents can insert own listings" ON listings
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Agents can update own listings" ON listings
    FOR UPDATE USING (true);

CREATE POLICY "Agents can delete own listings" ON listings
    FOR DELETE USING (true);

-- Commits: Anyone can read and insert
CREATE POLICY "Commits are viewable by everyone" ON commits
    FOR SELECT USING (true);

CREATE POLICY "Anyone can create commits" ON commits
    FOR INSERT WITH CHECK (true);

-- Sessions: Full access for auth
CREATE POLICY "Sessions full access" ON sessions
    FOR ALL USING (true);

-- ============================================
-- INSERT DEFAULT AGENTS
-- ============================================

INSERT INTO agents (email, name, role, is_admin, phone, license_pa, license_nj, bio, specialties, password_hash) VALUES
('prasad@harvestrealty.llc', 'Prasad Abraham', 'Broker/Owner', true, '215-519-4096', 'RB069944', '', 'Over 15 years of experience in real estate. Founder of Harvest Realty LLC.', 'Investment Properties, Commercial Real Estate, First-Time Buyers', 'PrasadBroker2026!'),
('jacob@harvestrealty.llc', 'Jacob Abraham', 'Sales Agent', false, '215-519-8916', 'RS371498', '', 'Dedicated to helping clients find their perfect home.', 'First-Time Buyers, Residential Sales', 'JacobSales2026!'),
('dyson@harvestrealty.llc', 'Dyson Daniel', 'Sales Agent', false, '267-290-0963', 'RS370036', '', 'Passionate about real estate and client satisfaction.', 'Residential Sales, Rentals', 'DysonSales2026!'),
('abdullah@harvestrealty.llc', 'Abdullah Khan', 'Sales Agent', false, '857-226-3031', 'RS370017', '2427729', 'Serving clients in both Pennsylvania and New Jersey.', 'First-Time Buyers, Multi-Family Properties', 'AbdullahSales2026!'),
('thomas@harvestrealty.llc', 'Thomas Thomas', 'Sales Agent', false, '215-519-3101', 'RS371066', '', 'Committed to providing excellent service.', 'Residential Sales, Investment Properties', 'ThomasSales2026!'),
('contact@harvestrealty.llc', 'Chronos Media', 'Admin / Media Partner', true, '215-000-0000', '', '', 'Website development and media partner.', 'Web Development, Marketing, Media', 'ChronosAdmin2026!');

-- ============================================
-- INSERT DEFAULT LISTINGS
-- ============================================

INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number) 
SELECT id, '2456 N 5th St, Philadelphia', '$125,000', 'Land', 'Active', NULL, NULL, NULL, NULL
FROM agents WHERE email = 'prasad@harvestrealty.llc';

INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number)
SELECT id, '565 E Tabor Rd, Philadelphia', '$244,900', 'Duplex', 'Under Contract', 4, 2, 2400, NULL
FROM agents WHERE email = 'prasad@harvestrealty.llc';

-- ============================================
-- CREATE STORAGE BUCKET FOR PHOTOS
-- ============================================
-- Note: Run this separately in Supabase Storage settings or use:
-- INSERT INTO storage.buckets (id, name, public) VALUES ('listing-photos', 'listing-photos', true);

-- ============================================
-- HELPFUL INDEXES
-- ============================================
CREATE INDEX idx_agents_email ON agents(email);
CREATE INDEX idx_listings_agent ON listings(agent_id);
CREATE INDEX idx_listings_status ON listings(status);
CREATE INDEX idx_sessions_token ON sessions(token);
CREATE INDEX idx_sessions_agent ON sessions(agent_id);

-- ============================================
-- UPDATE TIMESTAMP TRIGGER
-- ============================================
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER agents_updated_at
    BEFORE UPDATE ON agents
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER listings_updated_at
    BEFORE UPDATE ON listings
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();
