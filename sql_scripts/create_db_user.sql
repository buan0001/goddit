CREATE USER 'goddit_app'@'%' IDENTIFIED BY 'insecure';

GRANT SELECT, INSERT, UPDATE, DELETE ON goddit.* TO 'goddit_app'@'%';

-- Flush privileges to apply changes
FLUSH PRIVILEGES;