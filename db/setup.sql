DROP DATABASE IF EXISTS goddit_db;

CREATE DATABASE IF NOT EXISTS goddit_db;

USE goddit_db;

CREATE TABLE Sub_goddits(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(63) NOT NULL,
    description VARCHAR(2000),
    subscribers INT UNSIGNED DEFAULT 0,
    daily_users INT DEFAULT 0,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

CREATE TABLE User_activity(
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    sub_id INT NOT NULL,
    time_visited TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(sub_id) REFERENCES Sub_goddits(id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    INDEX idx_user_activity_sub_id (sub_id)
)

CREATE TABLE User_flairs(
    id INT NOT NULL AUTO_INCREMENT,
    body VARCHAR(50) NOT NULL,
    sub_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(sub_id) REFERENCES Sub_goddits(id) ON DELETE CASCADE,
    INDEX idx_user_flairs_sub_id (sub_id)
);

CREATE TABLE Post_flairs(
    id INT NOT NULL AUTO_INCREMENT,
    body VARCHAR(50) NOT NULL,
    sub_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(sub_id) REFERENCES Sub_goddits(id) ON DELETE CASCADE,
    INDEX idx_post_flairs_sub_id (sub_id)
);

CREATE TABLE Users(
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(40) NOT NULL,
    disabled BOOLEAN DEFAULT FALSE,
    role ENUM('user', 'admin') DEFAULT 'user',
    karma INT DEFAULT 0 NOT NULL,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    UNIQUE INDEX idx_username (username),
    UNIQUE INDEX idx_email (email)
);

CREATE TABLE Posts(
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
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE SET NULL,
    FOREIGN KEY(sub_id) REFERENCES Sub_goddits(id) ON DELETE CASCADE,
    INDEX idx_posts_sub_id (sub_id),
    INDEX idx_posts_user_id (user_id)
);

-- Move out of main table for query performance
CREATE TABLE Archived_Posts LIKE Posts;

CREATE TABLE Comments(
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
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE SET NULL,
    FOREIGN KEY(post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY(responds_to) REFERENCES Comments(id) ON DELETE SET NULL,
    INDEX idx_comments_post_id (post_id),
    INDEX idx_comments_responds_to (responds_to)
);

CREATE TABLE Events(
    title VARCHAR(255) NOT NULL,
    body VARCHAR(1000),
    start DATETIME NOT NULL,
    end DATETIME NOT NULL,
    organisor_id INT,
    FOREIGN KEY(organisor_id) REFERENCES Users(id) ON DELETE SET NULL,
    CHECK (start < end)
);

CREATE TABLE Event_participations(
    event_id INT ID NOT NULL,
    user_id INT ID NOT NULL,
    PRIMARY KEY(event_id, user_id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE SET NULL,
    FOREIGN KEY(event_id) REFERENCES Events(id) ON DELETE CASCADE,
)

CREATE TABLE Message_chains(
    id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id)
);

CREATE TABLE Message_chain_participants(
    user_id INT NOT NULL,
    chain_id INT NOT NULL,
    has_read BOOLEAN NOT NULL DEFAULT FALSE,
    read_only BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY(user_id, chain_id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(chain_id) REFERENCES Message_chains(id) ON DELETE CASCADE
);

CREATE TABLE Messages(
    id INT NOT NULL AUTO_INCREMENT,
    body VARCHAR(10000),
    sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sender_id INT,
    chain_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(sender_id) REFERENCES Users(id) ON DELETE SET NULL,
    FOREIGN KEY(chain_id) REFERENCES Message_chains(id) ON DELETE CASCADE
);

CREATE TABLE Purchases(
    id INT NOT NULL AUTO_INCREMENT,
    amount_paid FLOAT(7,2) NOT NULL,
    gold_recieved INT NOT NULL,
    user_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE SET NULL,
    CHECK (amount_paid > 0 AND gold_recieved > 0)
);

CREATE TABLE Award_types(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE Comment_awards(
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    comment_id INT,
    award_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(comment_id) REFERENCES Comments(id) ON DELETE CASCADE,
    FOREIGN KEY(award_id) REFERENCES Award_types(id) ON DELETE CASCADE
);

CREATE TABLE Post_awards(
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    award_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY(award_id) REFERENCES Award_types(id) ON DELETE CASCADE
);

CREATE TABLE Moderators(
    user_id INT NOT NULL,
    sub_id INT NOT NULL,
    role ENUM('moderator', 'owner') DEFAULT 'moderator',
    PRIMARY KEY(user_id, sub_id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(sub_id) REFERENCES Sub_goddits(id) ON DELETE CASCADE,
);

CREATE TABLE Subscriptions(
    user_id INT NOT NULL,
    sub_id INT NOT NULL,
    subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_flair_id INT,
    PRIMARY KEY(user_id, sub_id),
    FOREIGN KEY(user_flair_id) REFERENCES User_flairs(id) ON DELETE CASCADE,
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(sub_id) REFERENCES Sub_goddits(id) ON DELETE CASCADE,
    INDEX idx_subscriptions_user_id (user_id),
    INDEX idx_subscriptions_sub_id (sub_id)
);

CREATE TABLE Post_votes(
    is_upvote BOOLEAN NOT NULL,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    PRIMARY KEY(user_id, post_id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    INDEX idx_post_votes_user_id (user_id)
);

CREATE TABLE Comment_votes(
    positive BOOLEAN NOT NULL,
    user_id INT NOT NULL,
    comment_id INT NOT NULL,
    PRIMARY KEY(user_id, comment_id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(comment_id) REFERENCES Comments(id) ON DELETE CASCADE,
    INDEX idx_comment_votes_user_id (user_id)
);

-- TRIGGERS
DELIMITER //

CREATE TRIGGER after_subscribe
AFTER INSERT ON Subscriptions
FOR EACH ROW
BEGIN
    UPDATE Sub_goddits
    SET subscribers = subscribers + 1
    WHERE id = NEW.sub_id;
END//

CREATE TRIGGER after_unsubscribe
AFTER DELETE ON Subscriptions
FOR EACH ROW
BEGIN
    UPDATE Sub_goddits
    SET subscribers = subscribers - 1
    WHERE id = OLD.sub_id;
END//

CREATE TRIGGER prevent_created_update
BEFORE UPDATE ON Comments
FOR EACH ROW
BEGIN
    SET NEW.created_at = OLD.created_at;
END//

CREATE TRIGGER hide_comments_on_user_disable
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    IF NEW.disabled = TRUE THEN
        UPDATE Comments
        SET removed = TRUE
        WHERE user_id = NEW.id;
    END IF;
END//

CREATE TRIGGER hide_comments_on_user_delete
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    UPDATE Comments
    SET removed = TRUE
    WHERE user_id = OLD.id;
END//

CREATE TRIGGER enforce_message_participation
BEFORE INSERT ON Messages
FOR EACH ROW
BEGIN
    -- Check if the sender is part of the message chain
    IF NOT EXISTS (
        SELECT 1
        FROM Message_chain_participants
        WHERE user_id = NEW.sender_id
          AND chain_id = NEW.chain_id
    ) THEN
        -- Raise an error if the sender is not part of the chain
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User is not a participant in the message chain.';
    END IF;
END//

DELIMITER ;

-- EVENTS

-- Since we have slight data duplication by incrementing the subscriber count in 2 places, we do this to ensure daily data consistency
CREATE EVENT update_subscriber_counts
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    UPDATE Sub_goddits
    SET subscribers = (
        SELECT COUNT(*) FROM Subscriptions WHERE Subscriptions.sub_id = Sub_goddits.id
    );
END;


CREATE EVENT remove_expired_events
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    DELETE FROM Events WHERE end < NOW();
END;


CREATE EVENT notify_upcoming_events
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    SET @goddit_user_id = (SELECT id FROM Users WHERE username = 'Goddit');

    -- Loop through all upcoming events within the next day
    DECLARE done INT DEFAULT FALSE;
    DECLARE event_id INT;
    DECLARE event_title VARCHAR(255);

    -- Cursor to iterate over upcoming events
    DECLARE event_cursor CURSOR FOR
    SELECT id, title
    FROM Events
    WHERE start BETWEEN NOW() AND NOW() + INTERVAL 1 DAY;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN event_cursor;

    event_loop: LOOP
        -- Fetch the next event
        FETCH event_cursor INTO event_id, event_title;

        IF done THEN
            LEAVE event_loop;
        END IF;

        -- Create a new message chain for the event
        INSERT INTO Message_chains () VALUES ();
        SET @chain_id = LAST_INSERT_ID();

        -- Add participants to the message chain
        INSERT INTO Message_chain_participants (user_id, chain_id, has_read, read_only)
        SELECT DISTINCT Event_participations.user_id, @chain_id, FALSE, FALSE
        FROM Event_participations
        WHERE Event_participations.event_id = event_id;

        -- Send a message in the thread as "Goddit"
        INSERT INTO Messages (body, sent, sender_id, chain_id)
        VALUES (
            CONCAT('Reminder: The event "', event_title, '" is happening soon!'),
            NOW(),
            @goddit_user_id,
            @chain_id
        );
    END LOOP;

    -- Close the cursor
    CLOSE event_cursor;
END;


CREATE EVENT archive_old_posts
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    INSERT INTO Archived_Posts SELECT * FROM Posts WHERE created < NOW() - INTERVAL 2 YEAR;
    DELETE FROM Posts WHERE created < NOW() - INTERVAL 2 YEAR;
END;


-- First delete old user activity data, then recalculate the daily activity
CREATE EVENT delete_expired_user_activity
ON SCHEDULE EVERY 30 MINUTE
DO
BEGIN
    DELETE FROM User_activity
    WHERE time_visited < NOW() - INTERVAL 1 DAY;
END;

CREATE EVENT update_daily_visitors
ON SCHEDULE EVERY 30 MINUTE
DO
BEGIN
    UPDATE Sub_goddits
    SET daily_users = (
        SELECT COUNT(DISTINCT user_id)
        FROM User_activity
        WHERE User_activity.sub_id = Sub_goddits.id
    );
END;


-- VIEWS

CREATE VIEW active_sub_goddits AS
SELECT 
    id AS sub_id,
    name AS sub_name,
    description,
    daily_users,
    subscribers,
    created
FROM Sub_goddits
ORDER BY daily_users DESC;


CREATE VIEW user_post_activity AS
SELECT 
    u.id AS user_id,
    u.username,
    COUNT(DISTINCT p.id) AS total_posts,
    COUNT(DISTINCT c.id) AS total_comments,
    u.karma
FROM Users u
LEFT JOIN Posts p ON u.id = p.user_id
LEFT JOIN Comments c ON u.id = c.user_id
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
FROM Events e
JOIN Event_participations ep ON e.id = ep.event_id
JOIN Users u ON ep.user_id = u.id
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
FROM Posts p
LEFT JOIN Comments c ON p.id = c.post_id
LEFT JOIN Users u ON p.user_id = u.id
GROUP BY p.id, p.title, p.upvotes, p.downvotes, p.created, u.username
ORDER BY p.upvotes DESC, total_comments DESC;


CREATE VIEW moderator_activity AS
SELECT 
    m.sub_id,
    sg.name AS sub_name,
    m.user_id,
    u.username AS moderator_name,
    m.role AS moderator_role
FROM Moderators m
JOIN Sub_goddits sg ON m.sub_id = sg.id
JOIN Users u ON m.user_id = u.id
ORDER BY sg.name, m.role;


CREATE VIEW user_event_engagement AS
SELECT 
    u.id AS user_id,
    u.username,
    COUNT(ep.event_id) AS total_events
FROM Users u
LEFT JOIN Event_participations ep ON u.id = ep.user_id
GROUP BY u.id, u.username
ORDER BY total_events DESC;


CREATE VIEW get_user AS
SELECT 
    username,
    email,
    role,
    created
FROM Users;