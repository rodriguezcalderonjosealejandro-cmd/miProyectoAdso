-- 4. Índices B-Tree
CREATE UNIQUE INDEX idx_users_email ON users(email);

CREATE UNIQUE INDEX idx_tokens_token ON verification_tokens(token);

CREATE INDEX idx_tokens_user_id ON verification_tokens(user_id);