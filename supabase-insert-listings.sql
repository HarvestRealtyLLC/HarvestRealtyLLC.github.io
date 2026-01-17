-- ============================================
-- HARVEST REALTY - INSERT ALL EXISTING PROPERTIES
-- Run this in Supabase SQL Editor after initial setup
-- ============================================

-- First, clear any existing test listings (optional - comment out if you want to keep them)
-- DELETE FROM listings;

-- Get Prasad's agent ID for all listings (as the broker/owner)
-- We'll use a variable approach with a DO block

DO $$
DECLARE
    prasad_id UUID;
BEGIN
    -- Get Prasad's ID
    SELECT id INTO prasad_id FROM agents WHERE email = 'prasad@harvestrealty.llc';
    
    -- If Prasad doesn't exist, use the first admin
    IF prasad_id IS NULL THEN
        SELECT id INTO prasad_id FROM agents WHERE is_admin = true LIMIT 1;
    END IF;

    -- ============================================
    -- ACTIVE LISTINGS
    -- ============================================
    
    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '2456 N 5th St, Philadelphia, PA',
        '$125,000',
        'Land',
        'Active',
        NULL,
        NULL,
        NULL,
        'PAPH2527048',
        'photos/2456-n-5th-st.jpg',
        'Land opportunity in Philadelphia! This property offers excellent potential for development or investment. Located on N 5th St with convenient access to local amenities.'
    ) ON CONFLICT DO NOTHING;

    -- ============================================
    -- UNDER CONTRACT
    -- ============================================
    
    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '565 E Tabor Rd, Philadelphia, PA',
        '$244,900',
        'Duplex',
        'Under Contract',
        NULL,
        NULL,
        NULL,
        'PAPH2514428',
        'photos/565-e-tabor-rd.jpg',
        'Great investment opportunity! Duplex property under contract in Philadelphia.'
    ) ON CONFLICT DO NOTHING;

    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '7524 Whitaker Ave, Philadelphia, PA',
        '$259,900',
        'Residential',
        'Under Contract',
        3,
        1,
        NULL,
        'PAPH2518910',
        'photos/7524-whitaker-ave.jpg',
        'Charming 3-bedroom home under contract. Features include updated kitchen and spacious living areas.'
    ) ON CONFLICT DO NOTHING;

    -- ============================================
    -- SOLD PROPERTIES
    -- ============================================
    
    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '515 Foster St, Philadelphia, PA',
        '$256,000',
        'Duplex',
        'Sold',
        NULL,
        NULL,
        NULL,
        'PAPH2315284',
        'photos/515-foster-st.jpg',
        'Successfully sold duplex property. Great investment that generated strong returns for our client.'
    ) ON CONFLICT DO NOTHING;

    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '8604 Frontenac St, Philadelphia, PA',
        '$310,000',
        'Residential',
        'Sold',
        3,
        2,
        NULL,
        'PAPH2348768',
        'photos/8604-frontenac-st.jpg',
        'Beautiful 3-bedroom, 2-bathroom home sold to happy buyers.'
    ) ON CONFLICT DO NOTHING;

    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '11011 Lindsay St, Philadelphia, PA',
        '$317,500',
        'Residential',
        'Sold',
        4,
        1,
        NULL,
        'PAPH2306862',
        'photos/11011-lindsay-st.jpg',
        'Spacious 4-bedroom home successfully sold. Perfect for growing families.'
    ) ON CONFLICT DO NOTHING;

    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '664 Hendrix St, Philadelphia, PA',
        '$325,000',
        'Residential',
        'Sold',
        3,
        1,
        NULL,
        'PAPH2381180',
        'photos/664-hendrix-st.jpg',
        'Well-maintained 3-bedroom home sold above asking price.'
    ) ON CONFLICT DO NOTHING;

    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '8016 Langdon St, Philadelphia, PA',
        '$462,500',
        'Duplex',
        'Sold',
        NULL,
        NULL,
        NULL,
        'PAPH2362214',
        'photos/8016-langdon-st.jpg',
        'Prime duplex investment property sold. Excellent rental income potential realized.'
    ) ON CONFLICT DO NOTHING;

    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '11991 Lockart Rd, Philadelphia, PA',
        '$514,000',
        'Residential',
        'Sold',
        4,
        2,
        NULL,
        'PAPH2375898',
        'photos/11991-lockart-rd.jpg',
        'Stunning 4-bedroom, 2-bathroom home sold. Modern updates throughout.'
    ) ON CONFLICT DO NOTHING;

    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '586 Kismet Rd, Philadelphia, PA',
        '$569,000',
        'Residential',
        'Sold',
        5,
        3,
        NULL,
        'PAPH2465970',
        'photos/586-kismet-rd.jpg',
        'Luxurious 5-bedroom, 3-bathroom home sold. Premium finishes and spacious layout.'
    ) ON CONFLICT DO NOTHING;

    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '315 Myrtle Ave, Morton, PA',
        '$605,000',
        'Residential',
        'Sold',
        4,
        3,
        NULL,
        'PADE2069112',
        'photos/315-myrtle-ave.jpg',
        'Beautiful Delaware County home sold. 4 bedrooms, 3 bathrooms with modern amenities.'
    ) ON CONFLICT DO NOTHING;

    -- ============================================
    -- RENTAL PROPERTIES
    -- ============================================
    
    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '2485 Napfle St, Philadelphia, PA',
        '$895/mo',
        'Office',
        'Sold',
        NULL,
        NULL,
        NULL,
        'PAPH2520522',
        'photos/2485-napfle-st.jpg',
        'Professional office space available. Ideal for small businesses or startups.'
    ) ON CONFLICT DO NOTHING;

    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '419 Densmore Rd, Philadelphia, PA',
        '$2,300/mo',
        'Rental',
        'Sold',
        3,
        2,
        NULL,
        'PAPH2533022',
        'photos/419-densmore-rd.jpg',
        'Spacious 3-bedroom rental home. Updated kitchen and bathrooms. Ready for immediate move-in.'
    ) ON CONFLICT DO NOTHING;

    INSERT INTO listings (agent_id, address, price, property_type, status, beds, baths, sqft, mls_number, photo_url, description)
    VALUES (
        prasad_id,
        '11059 Bustleton Ave, Philadelphia, PA',
        '$3,000/mo',
        'Rental',
        'Sold',
        3,
        3,
        NULL,
        'PAPH2534602',
        'photos/11059-bustleton-ave.jpg',
        'Premium 3-bedroom, 3-bathroom rental. High-end finishes throughout. Prime Bustleton location.'
    ) ON CONFLICT DO NOTHING;

END $$;

-- ============================================
-- VERIFY LISTINGS WERE ADDED
-- ============================================
SELECT 
    address,
    price,
    property_type,
    status,
    beds,
    baths,
    mls_number
FROM listings 
ORDER BY 
    CASE status 
        WHEN 'Active' THEN 1 
        WHEN 'Under Contract' THEN 2 
        WHEN 'Sold' THEN 3 
        ELSE 4 
    END,
    created_at DESC;
