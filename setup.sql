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

    -- Create a message thread for each upcoming event within the next day
    INSERT INTO Message_chains ()
    SELECT NULL; -- Auto-increment ID for each new thread

    -- Add participants to the message thread
    INSERT INTO Message_chain_participants (user_id, chain_id, has_read, read_only)
    SELECT DISTINCT Subscriptions.user_id, LAST_INSERT_ID(), FALSE, FALSE
    FROM Subscriptions
    JOIN Events ON Subscriptions.sub_id = Events.organisor_id
    WHERE Events.start BETWEEN NOW() AND NOW() + INTERVAL 1 DAY;

    -- Send a message in the thread as "Goddit"
    INSERT INTO Messages (body, sent, sender_id, chain_id)
    SELECT CONCAT('Reminder: The event "', Events.title, '" is happening soon!'),
           NOW(),
           @goddit_user_id,
           LAST_INSERT_ID()
    FROM Events
    WHERE Events.start BETWEEN NOW() AND NOW() + INTERVAL 1 DAY;
END;
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

