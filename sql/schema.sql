-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- App Configuration Table
CREATE TABLE IF NOT EXISTS app_config (
    id SERIAL PRIMARY KEY,
    ai_name VARCHAR(255) DEFAULT 'CentralGPT',
    ai_persona TEXT,
    dev_name VARCHAR(255) DEFAULT 'XdpzQ',
    api_keys TEXT[] DEFAULT '{}',
    avatar_url TEXT,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    access_key VARCHAR(255) UNIQUE NOT NULL,
    role VARCHAR(50) DEFAULT 'user' CHECK (role IN ('admin', 'user')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    profile JSONB DEFAULT '{}',
    config JSONB DEFAULT '{}'
);

-- Chat Logs Table
CREATE TABLE IF NOT EXISTS chat_logs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50) CHECK (role IN ('user', 'model')),
    content TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert default admin user
INSERT INTO users (username, access_key, role, profile) 
VALUES ('dap', 'dap32', 'admin', '{"fullName": "Administrator", "address": "Localhost", "street": "Admin St", "zipCode": "00000", "country": "System"}')
ON CONFLICT (username) DO NOTHING;

-- Insert default configuration
INSERT INTO app_config (ai_name, ai_persona, dev_name, api_keys) 
VALUES ('CentralGPT', 'Your AI persona here...', 'XdpzQ', '{}')
ON CONFLICT (id) DO NOTHING;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_access_key ON users(access_key);
CREATE INDEX IF NOT EXISTS idx_chat_logs_user_id ON chat_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_chat_logs_created_at ON chat_logs(created_at);
