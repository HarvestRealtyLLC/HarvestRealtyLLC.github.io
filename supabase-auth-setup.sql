-- ============================================
-- SUPABASE AUTH SETUP FOR HARVEST REALTY
-- Run this in Supabase SQL Editor
-- ============================================

-- Step 1: Remove old password_hash column (no longer needed)
ALTER TABLE agents DROP COLUMN IF EXISTS password_hash;

-- Step 2: Add auth_id column to link with Supabase Auth users
ALTER TABLE agents ADD COLUMN IF NOT EXISTS auth_id UUID;

-- Step 3: Verify agents table structure
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'agents'
ORDER BY ordinal_position;

-- Step 4: View current agents (you'll need to create Auth users for these)
SELECT id, name, email, role, is_admin 
FROM agents 
ORDER BY is_admin DESC, name;

-- ============================================
-- AFTER creating Auth users via Dashboard:
-- Go to Authentication → Users → Invite User
-- Enter each agent's email
-- They'll receive an email to set their password
-- ============================================

-- Step 5: Link auth users to agents (run AFTER inviting users)
-- This updates the auth_id column to match Supabase Auth users
UPDATE agents a
SET auth_id = u.id
FROM auth.users u
WHERE LOWER(a.email) = LOWER(u.email);

-- Step 6: Verify the links worked
SELECT 
    a.name, 
    a.email, 
    a.is_admin,
    a.auth_id,
    CASE WHEN a.auth_id IS NOT NULL THEN '✅ Linked' ELSE '❌ Not linked' END as status
FROM agents a
ORDER BY a.is_admin DESC, a.name;

-- ============================================
-- OPTIONAL: Row Level Security Policies
-- Uncomment and run if you want to enable RLS
-- ============================================

/*
-- Enable RLS
ALTER TABLE listings ENABLE ROW LEVEL SECURITY;

-- Anyone can read listings (for public website)
CREATE POLICY "Public read access" ON listings
    FOR SELECT USING (true);

-- Authenticated agents can insert listings
CREATE POLICY "Agents can insert listings" ON listings
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Agents can update/delete their own listings
CREATE POLICY "Agents can modify own listings" ON listings
    FOR UPDATE USING (
        agent_id IN (SELECT id FROM agents WHERE auth_id = auth.uid())
    );

CREATE POLICY "Agents can delete own listings" ON listings
    FOR DELETE USING (
        agent_id IN (SELECT id FROM agents WHERE auth_id = auth.uid())
    );

-- Admins can do everything
CREATE POLICY "Admins full access" ON listings
    FOR ALL USING (
        EXISTS (SELECT 1 FROM agents WHERE auth_id = auth.uid() AND is_admin = true)
    );
*/
