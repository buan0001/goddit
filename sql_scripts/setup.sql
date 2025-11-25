DROP DATABASE IF EXISTS goddit;

CREATE DATABASE IF NOT EXISTS goddit;

USE goddit;

CREATE TABLE sub_goddits(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(63) NOT NULL,
    description VARCHAR(2000),
    subscribers INT UNSIGNED DEFAULT 0,
    daily_users INT DEFAULT 0,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);


CREATE TABLE user_flairs(
    id INT NOT NULL AUTO_INCREMENT,
    body VARCHAR(50) NOT NULL,
    sub_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(sub_id) REFERENCES sub_goddits(id) ON DELETE CASCADE,
    INDEX idx_user_flairs_sub_id (sub_id)
);

CREATE TABLE post_flairs(
    id INT NOT NULL AUTO_INCREMENT,
    body VARCHAR(50) NOT NULL,
    sub_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(sub_id) REFERENCES sub_goddits(id) ON DELETE CASCADE,
    INDEX idx_post_flairs_sub_id (sub_id)
);

CREATE TABLE users(
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(60) NOT NULL, -- 60 to match bcrypt hash length
    disabled BOOLEAN DEFAULT FALSE,
    role ENUM('user', 'admin') DEFAULT 'user',
    karma INT DEFAULT 0 NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    UNIQUE INDEX idx_username (username),
    UNIQUE INDEX idx_email (email)
);

CREATE TABLE user_activity(
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    sub_id INT NOT NULL,
    time_visited TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(sub_id) REFERENCES sub_goddits(id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY(id),
    INDEX idx_user_activity_sub_id (sub_id),
    INDEX idx_user_activity_user_id (user_id)
);


CREATE TABLE posts(
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    body VARCHAR(8191),
    upvotes INT DEFAULT 0 NOT NULL,
    downvotes INT DEFAULT 0 NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP,
    user_id INT,
    sub_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY(sub_id) REFERENCES sub_goddits(id) ON DELETE CASCADE,
    INDEX idx_posts_sub_id (sub_id),
    INDEX idx_posts_user_id (user_id)
);

-- Move out of main table for query performance
CREATE TABLE archived_posts LIKE posts;

CREATE TABLE comments(
    id INT NOT NULL AUTO_INCREMENT,
    upvotes INT DEFAULT 0 NOT NULL,
    downvotes INT DEFAULT 0 NOT NULL,
    body VARCHAR(8191) NOT NULL,
    removed BOOLEAN DEFAULT FALSE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT,
    post_id INT NOT NULL,
    responds_to INT DEFAULT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY(post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY(responds_to) REFERENCES comments(id) ON DELETE SET NULL,
    INDEX idx_comments_post_id (post_id),
    INDEX idx_comments_responds_to (responds_to)
);

CREATE TABLE events(
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    body VARCHAR(1000),
    start DATETIME NOT NULL,
    end DATETIME NOT NULL,
    organisor_id INT,
    FOREIGN KEY(organisor_id) REFERENCES users(id) ON DELETE SET NULL,
    PRIMARY KEY(id),
    CHECK (start < end)
);

CREATE TABLE event_participations(
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY(event_id, user_id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(event_id) REFERENCES events(id) ON DELETE CASCADE
);

CREATE TABLE message_chains(
    id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id)
);

CREATE TABLE message_chain_participants(
    user_id INT NOT NULL,
    chain_id INT NOT NULL,
    has_read BOOLEAN NOT NULL DEFAULT FALSE,
    read_only BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY(user_id, chain_id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(chain_id) REFERENCES message_chains(id) ON DELETE CASCADE
);

CREATE TABLE messages(
    id INT NOT NULL AUTO_INCREMENT,
    body VARCHAR(10000),
    sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sender_id INT,
    chain_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(sender_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY(chain_id) REFERENCES message_chains(id) ON DELETE CASCADE
);

CREATE TABLE purchases(
    id INT NOT NULL AUTO_INCREMENT,
    amount_paid FLOAT(7,2) NOT NULL,
    gold_recieved INT NOT NULL,
    user_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL,
    CHECK (amount_paid > 0 AND gold_recieved > 0)
);

CREATE TABLE award_types(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE comment_awards(
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    comment_id INT,
    award_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(comment_id) REFERENCES comments(id) ON DELETE CASCADE,
    FOREIGN KEY(award_id) REFERENCES award_types(id) ON DELETE CASCADE
);

CREATE TABLE post_awards(
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    award_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY(award_id) REFERENCES award_types(id) ON DELETE CASCADE
);

CREATE TABLE moderators(
    user_id INT NOT NULL,
    sub_id INT NOT NULL,
    role ENUM('moderator', 'owner') DEFAULT 'moderator',
    PRIMARY KEY(user_id, sub_id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(sub_id) REFERENCES sub_goddits(id) ON DELETE CASCADE
);

CREATE TABLE subscriptions(
    user_id INT NOT NULL,
    sub_id INT NOT NULL,
    subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_flair_id INT,
    PRIMARY KEY(user_id, sub_id),
    FOREIGN KEY(user_flair_id) REFERENCES user_flairs(id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(sub_id) REFERENCES sub_goddits(id) ON DELETE CASCADE,
    INDEX idx_subscriptions_user_id (user_id),
    INDEX idx_subscriptions_sub_id (sub_id)
);

CREATE TABLE post_votes(
    is_upvote BOOLEAN NOT NULL,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    PRIMARY KEY(user_id, post_id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(post_id) REFERENCES posts(id) ON DELETE CASCADE,
    INDEX idx_post_votes_user_id (user_id)
);

CREATE TABLE comment_votes(
    positive BOOLEAN NOT NULL,
    user_id INT NOT NULL,
    comment_id INT NOT NULL,
    PRIMARY KEY(user_id, comment_id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(comment_id) REFERENCES comments(id) ON DELETE CASCADE,
    INDEX idx_comment_votes_user_id (user_id)
);

-- TRIGGERS

DELIMITER $$

CREATE TRIGGER after_subscribe
AFTER INSERT ON subscriptions
FOR EACH ROW
BEGIN
    UPDATE sub_goddits
    SET subscribers = subscribers + 1
    WHERE id = NEW.sub_id;
END $$

CREATE TRIGGER after_unsubscribe
AFTER DELETE ON subscriptions
FOR EACH ROW
BEGIN
    UPDATE sub_goddits
    SET subscribers = subscribers - 1
    WHERE id = OLD.sub_id;
END $$

CREATE TRIGGER prevent_created_update
BEFORE UPDATE ON comments
FOR EACH ROW
BEGIN
    SET NEW.created_at = OLD.created_at;
END $$

CREATE TRIGGER hide_comments_on_user_disable
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.disabled = TRUE THEN
        UPDATE comments
        SET removed = TRUE
        WHERE user_id = NEW.id;
    END IF;
END $$

CREATE TRIGGER hide_comments_on_user_delete
AFTER DELETE ON users
FOR EACH ROW
BEGIN
    UPDATE comments
    SET removed = TRUE
    WHERE user_id = OLD.id;
END $$


CREATE TRIGGER enforce_message_participation
BEFORE INSERT ON messages
FOR EACH ROW
BEGIN
    -- Check if the sender is part of the message chain
    IF NOT EXISTS (
        SELECT 1
        FROM message_chain_participants
        WHERE user_id = NEW.sender_id
          AND chain_id = NEW.chain_id
    ) THEN
        -- Raise an error if the sender is not part of the chain
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User is not a participant in the message chain.';
    END IF;
END $$

-- Part to ensure archived posts stay unchanged

CREATE TRIGGER prevent_comment_changes_on_archived_post
BEFORE UPDATE ON comments
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM archived_posts
        WHERE archived_posts.id = NEW.post_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot modify comments on an archived post.';
    END IF;
END $$


CREATE TRIGGER prevent_comment_deletion_on_archived_post
BEFORE DELETE ON comments
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM archived_posts
        WHERE archived_posts.id = OLD.post_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete comments on an archived post.';
    END IF;
END $$


CREATE TRIGGER prevent_vote_changes_on_archived_post
BEFORE UPDATE ON post_votes
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM archived_posts
        WHERE archived_posts.id = NEW.post_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot modify votes on an archived post.';
    END IF;
END $$


CREATE TRIGGER prevent_vote_deletion_on_archived_post
BEFORE DELETE ON post_votes
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM archived_posts
        WHERE archived_posts.id = OLD.post_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete votes on an archived post.';
    END IF;
END $$


CREATE TRIGGER prevent_post_changes_on_archived_post
BEFORE UPDATE ON posts
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM archived_posts
        WHERE archived_posts.id = NEW.id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot modify an archived post.';
    END IF;
END $$


CREATE TRIGGER prevent_post_deletion_on_archived_post
BEFORE DELETE ON posts
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM archived_posts
        WHERE archived_posts.id = OLD.id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete an archived post.';
    END IF;
END $$


DELIMITER ;

-- EVENTS

-- Since we have slight data duplication by incrementing the subscriber count in 2 places, we do this to ensure daily data consistency

DELIMITER $$

CREATE EVENT update_subscriber_counts
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    UPDATE sub_goddits
    SET subscribers = (
        SELECT COUNT(*) FROM subscriptions WHERE subscriptions.sub_id = sub_goddits.id
    );
END $$

CREATE EVENT remove_expired_events
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    DELETE FROM events WHERE end < NOW();
END $$

CREATE EVENT archive_old_posts
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    INSERT INTO archived_posts SELECT * FROM posts WHERE created < NOW() - INTERVAL 2 YEAR;
    DELETE FROM posts WHERE created < NOW() - INTERVAL 2 YEAR;
END $$

-- First delete old user activity data, then recalculate the daily activity
CREATE EVENT delete_expired_user_activity
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
    DELETE FROM user_activity
    WHERE time_visited < NOW() - INTERVAL 1 DAY;
END $$

CREATE EVENT update_daily_visitors
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
    UPDATE sub_goddits
    SET daily_users = (
        SELECT COUNT(DISTINCT user_id)
        FROM user_activity
        WHERE user_activity.sub_id = sub_goddits.id
    );
END $$

DELIMITER ;

-- VIEWS

CREATE VIEW active_sub_goddits AS
SELECT 
    id AS sub_id,
    name AS sub_name,
    description,
    daily_users,
    subscribers,
    created
FROM sub_goddits
ORDER BY daily_users DESC;


CREATE VIEW user_post_activity AS
SELECT 
    u.id AS user_id,
    u.username,
    COUNT(DISTINCT p.id) AS total_posts,
    COUNT(DISTINCT c.id) AS total_comments,
    u.karma
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
LEFT JOIN comments c ON u.id = c.user_id
GROUP BY u.id, u.username, u.karma
ORDER BY total_posts DESC, total_comments DESC;


CREATE VIEW event_participants AS
SELECT 
    e.id AS event_id,
    e.title AS event_title,
    e.start AS event_start,
    e.end AS event_end,
    u.id AS user_id,
    u.username AS participant_name
FROM events e
JOIN event_participations ep ON e.id = ep.event_id
JOIN users u ON ep.user_id = u.id
ORDER BY e.start, e.title;


CREATE VIEW post_engagement AS
SELECT 
    p.id AS post_id,
    p.title AS post_title,
    p.upvotes,
    p.downvotes,
    COUNT(c.id) AS total_comments,
    p.created AS post_created,
    u.username AS author
FROM posts p
LEFT JOIN comments c ON p.id = c.post_id
LEFT JOIN users u ON p.user_id = u.id
GROUP BY p.id, p.title, p.upvotes, p.downvotes, p.created, u.username
ORDER BY p.upvotes DESC, total_comments DESC;


CREATE VIEW moderator_activity AS
SELECT 
    m.sub_id,
    sg.name AS sub_name,
    m.user_id,
    u.username AS moderator_name,
    m.role AS moderator_role
FROM moderators m
JOIN sub_goddits sg ON m.sub_id = sg.id
JOIN users u ON m.user_id = u.id
ORDER BY sg.name, m.role;


CREATE VIEW user_event_engagement AS
SELECT 
    u.id AS user_id,
    u.username,
    COUNT(ep.event_id) AS total_events
FROM users u
LEFT JOIN event_participations ep ON u.id = ep.user_id
GROUP BY u.id, u.username
ORDER BY total_events DESC;


CREATE VIEW get_user AS
SELECT 
    username,
    email,
    role,
    created
FROM users;