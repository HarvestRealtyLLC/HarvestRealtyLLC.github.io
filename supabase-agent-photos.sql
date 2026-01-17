-- ============================================
-- ADD PHOTO_URL TO AGENTS TABLE
-- Run this in Supabase SQL Editor
-- ============================================

-- Add photo_url column if it doesn't exist
ALTER TABLE agents 
ADD COLUMN IF NOT EXISTS photo_url TEXT;

-- Verify the column was added
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'agents';

-- ============================================
-- UPDATE AGENT PHOTOS (Optional)
-- Uncomment and modify these to set agent photos
-- ============================================

-- UPDATE agents SET photo_url = 'photos/prasad-abraham.jpg' WHERE email = 'prasad@harvestrealty.llc';
-- UPDATE agents SET photo_url = 'photos/jacob-abraham.jpg' WHERE email = 'jacob@harvestrealty.llc';
-- UPDATE agents SET photo_url = 'photos/dyson-daniel.jpg' WHERE email = 'dyson@harvestrealty.llc';
-- UPDATE agents SET photo_url = 'photos/abdullah-khan.jpg' WHERE email = 'abdullah@harvestrealty.llc';
-- UPDATE agents SET photo_url = 'photos/thomas-thomas.jpg' WHERE email = 'thomas@harvestrealty.llc';

-- ============================================
-- VIEW ALL AGENTS
-- ============================================
SELECT id, name, email, role, phone, license_pa, license_nj, photo_url
FROM agents
ORDER BY 
    CASE role 
        WHEN 'Broker/Owner' THEN 1 
        WHEN 'Sales Agent' THEN 2 
        ELSE 3 
    END;
