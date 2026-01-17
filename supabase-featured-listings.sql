-- Add is_featured column to listings table
-- Run this in your Supabase SQL Editor

ALTER TABLE listings ADD COLUMN IF NOT EXISTS is_featured BOOLEAN DEFAULT false;

-- Create index for faster featured queries
CREATE INDEX IF NOT EXISTS idx_listings_featured ON listings(is_featured) WHERE is_featured = true;

-- Optional: Set some initial featured listings (update IDs as needed)
-- UPDATE listings SET is_featured = true WHERE id IN ('id1', 'id2', 'id3', 'id4', 'id5', 'id6');

SELECT 'is_featured column added successfully!' as status;
