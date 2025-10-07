-- Ensure the "Goddit" admin account exists
INSERT INTO Users (username, email, password, role, created)
SELECT 'Goddit', 'admin@goddit.com', 'securepassword', 'admin', NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM Users WHERE username = 'Goddit'
);