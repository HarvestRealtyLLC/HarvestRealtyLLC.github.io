-- ============================================
-- REMOVE DUPLICATE LISTINGS
-- Keeps the OLDEST entry for each address (first inserted)
-- Run this in Supabase SQL Editor
-- ============================================

-- First, let's see the duplicates
SELECT address, COUNT(*) as count
FROM listings
GROUP BY address
HAVING COUNT(*) > 1
ORDER BY count DESC;

-- Delete duplicates, keeping the oldest (first created) entry for each address
DELETE FROM listings
WHERE id IN (
    SELECT id FROM (
        SELECT 
            id,
            ROW_NUMBER() OVER (
                PARTITION BY address 
                ORDER BY created_at ASC
            ) as row_num
        FROM listings
    ) duplicates
    WHERE row_num > 1
);

-- Verify duplicates are gone
SELECT address, COUNT(*) as count
FROM listings
GROUP BY address
HAVING COUNT(*) > 1;

-- Show remaining listings
SELECT id, address, price, status, created_at
FROM listings
ORDER BY created_at DESC;
