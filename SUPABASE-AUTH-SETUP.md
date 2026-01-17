# Supabase Auth Setup for Harvest Realty Agent Portal

## Overview
This guide will help you set up proper authentication with Supabase Auth for your agent portal. This replaces the simple password check with secure, industry-standard authentication including:

- ✅ Secure password hashing (bcrypt)
- ✅ Email verification on signup
- ✅ Password reset via email
- ✅ JWT session tokens
- ✅ Optional: Email OTP for 2FA

---

## Step 1: Enable Email Auth in Supabase

1. Go to your Supabase Dashboard: https://supabase.com/dashboard
2. Select your project: `zzjunmkcdpdxhmhiggno`
3. Navigate to **Authentication** → **Providers**
4. Ensure **Email** is enabled
5. Configure settings:
   - ✅ Enable email confirmations (recommended)
   - ✅ Enable secure password recovery

---

## Step 2: Configure Email Templates

1. Go to **Authentication** → **Email Templates**
2. Customize these templates with your branding:

### Confirm Signup Email
```
Subject: Welcome to Harvest Realty - Confirm Your Email

<h2>Welcome to Harvest Realty LLC!</h2>
<p>Hi there,</p>
<p>Click the link below to confirm your email and access the Agent Portal:</p>
<p><a href="{{ .ConfirmationURL }}">Confirm Email Address</a></p>
<p>This link expires in 24 hours.</p>
<p>Best regards,<br>Harvest Realty Team</p>
```

### Reset Password Email
```
Subject: Reset Your Harvest Realty Password

<h2>Password Reset Request</h2>
<p>Hi there,</p>
<p>Click the link below to reset your password:</p>
<p><a href="{{ .ConfirmationURL }}">Reset Password</a></p>
<p>If you didn't request this, you can safely ignore this email.</p>
<p>Best regards,<br>Harvest Realty Team</p>
```

---

## Step 3: Create Auth Users for Existing Agents

You need to create Supabase Auth users for each agent. Run this in the Supabase SQL Editor:

```sql
-- ============================================
-- CREATE AUTH USERS FOR EXISTING AGENTS
-- Run this in Supabase SQL Editor
-- ============================================

-- IMPORTANT: You'll need to invite users via the Dashboard or use the Admin API
-- This script just prepares the agents table

-- First, let's see current agents
SELECT id, name, email, role, is_admin FROM agents ORDER BY is_admin DESC, name;

-- Remove the password_hash column (no longer needed with Supabase Auth)
-- The password is now securely managed by Supabase Auth
ALTER TABLE agents DROP COLUMN IF EXISTS password_hash;

-- Add auth_id column to link agents to Supabase Auth users
ALTER TABLE agents ADD COLUMN IF NOT EXISTS auth_id UUID REFERENCES auth.users(id);

-- Verify the schema
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'agents'
ORDER BY ordinal_position;
```

---

## Step 4: Invite Agents via Supabase Dashboard

For each agent, you need to create a Supabase Auth user:

### Option A: Dashboard (Recommended for small teams)

1. Go to **Authentication** → **Users**
2. Click **"Invite user"**
3. Enter the agent's email (e.g., `prasad@harvestrealty.llc`)
4. They'll receive an email to set their password

### Option B: Use Admin API (For bulk creation)

You can use the Supabase Admin API to create users programmatically. Here's a Node.js example:

```javascript
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  'https://zzjunmkcdpdxhmhiggno.supabase.co',
  'YOUR_SERVICE_ROLE_KEY' // Use service role key, not anon key
);

async function createAgentUser(email, password) {
  const { data, error } = await supabase.auth.admin.createUser({
    email: email,
    password: password,
    email_confirm: true // Skip email confirmation
  });
  
  if (error) {
    console.error('Error creating user:', error);
    return null;
  }
  
  console.log('User created:', data.user.id);
  return data.user;
}

// Create users for each agent
const agents = [
  { email: 'prasad@harvestrealty.llc', password: 'TempPassword123!' },
  { email: 'jacob@harvestrealty.llc', password: 'TempPassword123!' },
  { email: 'dyson@harvestrealty.llc', password: 'TempPassword123!' },
  { email: 'abdullah@harvestrealty.llc', password: 'TempPassword123!' },
  { email: 'thomas@harvestrealty.llc', password: 'TempPassword123!' },
  { email: 'contact@harvestrealty.llc', password: 'TempPassword123!' }
];

agents.forEach(agent => createAgentUser(agent.email, agent.password));
```

---

## Step 5: Link Auth Users to Agents Table (Optional)

After creating auth users, you can link them to the agents table:

```sql
-- Update agents table with auth_id after users are created
-- Run this after creating auth users

UPDATE agents 
SET auth_id = auth.users.id
FROM auth.users
WHERE agents.email = auth.users.email;

-- Verify the links
SELECT a.name, a.email, a.auth_id, u.email as auth_email
FROM agents a
LEFT JOIN auth.users u ON a.auth_id = u.id;
```

---

## Step 6: Set Up Row Level Security (RLS)

Enable RLS to secure your data based on authenticated users:

```sql
-- Enable RLS on tables
ALTER TABLE agents ENABLE ROW LEVEL SECURITY;
ALTER TABLE listings ENABLE ROW LEVEL SECURITY;

-- Agents can read all agents (for team display)
CREATE POLICY "Agents can view all agents" ON agents
    FOR SELECT USING (true);

-- Agents can only update their own profile
CREATE POLICY "Agents can update own profile" ON agents
    FOR UPDATE USING (auth.uid() = auth_id);

-- Admins can do everything
CREATE POLICY "Admins have full access to agents" ON agents
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM agents 
            WHERE auth_id = auth.uid() AND is_admin = true
        )
    );

-- Listings: Anyone can read
CREATE POLICY "Anyone can view listings" ON listings
    FOR SELECT USING (true);

-- Listings: Agents can manage their own
CREATE POLICY "Agents can manage own listings" ON listings
    FOR ALL USING (
        agent_id IN (
            SELECT id FROM agents WHERE auth_id = auth.uid()
        )
    );

-- Listings: Admins can manage all
CREATE POLICY "Admins can manage all listings" ON listings
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM agents 
            WHERE auth_id = auth.uid() AND is_admin = true
        )
    );
```

---

## Step 7: Test the Login

1. Upload the new `portal.html` to your website
2. Go to `harvestrealty.llc/portal.html`
3. Try logging in with an agent's email and password
4. The password should be the one set via Supabase invite or Admin API

---

## Troubleshooting

### "Invalid login credentials"
- User doesn't exist in Supabase Auth
- Password is incorrect
- Solution: Re-invite the user or reset their password

### "Email not confirmed"
- User hasn't clicked the confirmation link
- Solution: Resend invitation from Dashboard or set `email_confirm: true` when creating

### "Agent profile not found"
- User exists in Auth but not in agents table
- Solution: Add the agent to the agents table with matching email

---

## Security Notes

1. **Never expose the Service Role Key** - Only use it server-side
2. **Anon Key is safe for client-side** - It respects RLS policies
3. **Enable RLS** on all tables with sensitive data
4. **Use HTTPS** - Supabase requires it for auth

---

## Quick Reference

- **Supabase Dashboard**: https://supabase.com/dashboard/project/zzjunmkcdpdxhmhiggno
- **Auth Users**: Authentication → Users
- **Email Templates**: Authentication → Email Templates
- **SQL Editor**: SQL Editor (left sidebar)
