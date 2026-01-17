-- ============================================
-- ADD PROFILE FIELDS TO AGENTS TABLE
-- Run this in Supabase SQL Editor
-- ============================================

-- Add photo_url column for agent profile photos
ALTER TABLE agents ADD COLUMN IF NOT EXISTS photo_url TEXT;

-- Add bio column for agent biography
ALTER TABLE agents ADD COLUMN IF NOT EXISTS bio TEXT;

-- Add specialties column (comma-separated list)
ALTER TABLE agents ADD COLUMN IF NOT EXISTS specialties TEXT;

-- Verify columns were added
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'agents'
ORDER BY ordinal_position;

-- ============================================
-- SET DEFAULT VALUES FOR EXISTING AGENTS
-- ============================================

-- Prasad Abraham
UPDATE agents SET 
    photo_url = 'photos/prasad-abraham.png',
    bio = 'Welcome! I''m Prasad Abraham, the Broker and Owner of Harvest Realty LLC. With years of experience in the Pennsylvania and New Jersey real estate markets, I''m dedicated to helping clients achieve their property goals.

Whether you''re buying your first home, selling a property, or looking for investment opportunities, I provide personalized service and expert guidance every step of the way.',
    specialties = 'Residential Sales,Property Management,Investment Properties,First-Time Home Buyers,Philadelphia Area,New Jersey'
WHERE email = 'prasad@harvestrealty.llc';

-- Jacob Abraham
UPDATE agents SET 
    photo_url = 'photos/jacob-abraham.png',
    bio = 'Hi, I''m Jacob Abraham, a dedicated Sales Agent at Harvest Realty LLC. I''m passionate about helping clients find their perfect home in the Greater Philadelphia area.

With a focus on exceptional customer service and market knowledge, I guide buyers and sellers through every step of the real estate process.',
    specialties = 'Buyer Representation,Seller Representation,First-Time Buyers,Philadelphia Metro,Customer Service'
WHERE email = 'jacob@harvestrealty.llc';

-- Dyson Daniel
UPDATE agents SET 
    photo_url = 'photos/dyson-daniel.png',
    bio = 'Hello! I''m Dyson Daniel, a Sales Agent at Harvest Realty LLC. I bring energy and dedication to every transaction, ensuring my clients have a smooth and successful real estate experience.

Whether you''re buying or selling, I''m here to provide expert guidance and support.',
    specialties = 'Residential Sales,New Construction,Investment Properties,Market Analysis,Client Relations'
WHERE email = 'dyson@harvestrealty.llc';

-- Abdullah Khan
UPDATE agents SET 
    photo_url = 'photos/abdullah-khan.png',
    bio = 'Assalamu Alaikum! I''m Abdullah Khan, a Sales Agent at Harvest Realty LLC. I specialize in serving diverse communities and helping families find homes that meet their unique needs.

My commitment to honesty, integrity, and hard work ensures that every client receives the best possible service.',
    specialties = 'Residential Sales,Multi-Family Properties,Community Outreach,Buyer Education,Negotiation'
WHERE email = 'abdullah@harvestrealty.llc';

-- Thomas Thomas
UPDATE agents SET 
    photo_url = 'photos/thomas-thomas.png',
    bio = 'Welcome! I''m Thomas Thomas, a Sales Agent at Harvest Realty LLC. With a passion for real estate and a commitment to excellence, I help clients navigate the buying and selling process with confidence.

I believe in building lasting relationships and providing personalized service to every client.',
    specialties = 'Buyer Representation,Listing Agent,Property Valuation,Market Research,Client Advocacy'
WHERE email = 'thomas@harvestrealty.llc';

-- ============================================
-- VERIFY THE UPDATES
-- ============================================
SELECT name, email, role, photo_url, 
       LEFT(bio, 50) || '...' as bio_preview,
       specialties
FROM agents
ORDER BY 
    CASE role 
        WHEN 'Broker/Owner' THEN 1 
        ELSE 2 
    END, name;
