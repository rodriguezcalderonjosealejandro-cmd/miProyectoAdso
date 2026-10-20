CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 2. Tabla Principal de Usuarios
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(150) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'user',
    is_verified BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT chk_users_role CHECK (role IN ('admin', 'user'))



    CONSTRAINT fk_tokens_user FOREIGN KEY (user_id)
     REFERENCES users(id) 
     ON DELETE CASCADE,


    CONSTRAINT uq_tokens_token UNIQUE (token)
    );


