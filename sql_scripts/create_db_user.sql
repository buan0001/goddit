-- Create the user
CREATE USER 'goddit_app'@'%' IDENTIFIED BY 'insecure';

-- Grant limited privileges to the user
GRANT SELECT, INSERT, UPDATE, DELETE ON goddit.* TO 'goddit_app'@'%';

-- Flush privileges to apply changes
FLUSH PRIVILEGES;

-- Optional: Verify the user's privileges
SHOW GRANTS FOR 'goddit_app'@'%';