
BEGIN;

-- Paso 1: Insertar usuario de prueba si no existe
INSERT INTO users (
    id,
    email,
    password_hash,
    role,
    is_verified
)
VALUES (
    'b0000000-0000-0000-0000-000000000002',
    'aprendiz.adso@misena.edu.co',
    '$2a$12$k9L2m4n6p8q0r2t4v6x8.z0a2c4e6g8i0k2m4n6p8q0r2t4v6x8z0',
    'user',
    FALSE
)
ON CONFLICT (id) DO NOTHING;

-- Paso 2: Crear un token solo si todavía no existe
-- un token de verificación vigente para ese usuario.
INSERT INTO verification_tokens (
    user_id,
    token,
    expires_at
)
SELECT
    'b0000000-0000-0000-0000-000000000002',
    encode(gen_random_bytes(32), 'hex'),
    NOW() + INTERVAL '24 hours'
WHERE EXISTS (
    SELECT 1
    FROM users
    WHERE id = 'b0000000-0000-0000-0000-000000000002'
)
AND NOT EXISTS (
    SELECT 1
    FROM verification_tokens
    WHERE user_id = 'b0000000-0000-0000-0000-000000000002'
      AND expires_at > NOW()
);

COMMIT;
