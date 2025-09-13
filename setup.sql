DROP DATABASE IF EXISTS goddit_db;

CREATE DATABASE IF NOT EXISTS goddit_db;

USE goddit_db;

CREATE TABLE Subs(
    id INT NOT NULL AUTO_INCREMENT,
    name varchar(63) NOT NULL ,
    description VARCHAR(8191),
    subscriber_count INT UNSIGNED DEFAULT 0,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

CREATE TABLE Users(
    id INT NOT NULL AUTO_INCREMENT,
    username varchar(255) UNIQUE,
    password varchar(40) NOT NULL ,
    disabled boolean DEFAULT FALSE,
    registered TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role ENUM('user','admin') DEFAULT 'user',
    PRIMARY KEY(id)
);

-- Very basic posts for now. Simple text posts are all that's allowed!
CREATE TABLE Posts(
    id int NOT NULL AUTO_INCREMENT,
    body varchar(8191),
    upvotes INT DEFAULT 0 NOT NULL,
    user_id INT,
    sub_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE SET NULL,
    FOREIGN KEY(sub_id) REFERENCES Subs(id) ON DELETE CASCADE
);

CREATE TABLE Comments(
    id INT NOT NULL AUTO_INCREMENT,
    comment_ref VARCHAR(20) NOT NULL,
    upvotes INT DEFAULT 0 NOT NULL,
    body VARCHAR(8191) NOT NULL,
    removed BOOLEAN DEFAULT FALSE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT,
    post_id INT NOT NULL,
    responds_to INT DEFAULT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE SET NULL,
    FOREIGN KEY(post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (responds_to) REFERENCES Comments(id) ON DELETE SET NULL
);

-- JOIN TABLE SECTION

CREATE TABLE SubMods (
    user_id INT NOT NULL,
    sub_id INT NOT NULL,
    role ENUM('moderator','owner') DEFAULT 'moderator',
    PRIMARY KEY (user_id, sub_id),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (sub_id) REFERENCES Subs(id) ON DELETE CASCADE
);

CREATE TABLE SubscribesTo (
    user_id INT NOT NULL,
    sub_id INT NOT NULL,
    subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- optional, to track when the user subscribed
    PRIMARY KEY(user_id, sub_id),  -- composite PK ensures no duplicates
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(sub_id) REFERENCES Subs(id) ON DELETE CASCADE
);

CREATE TABLE PostsVotedOn(
    positive BOOLEAN NOT NULL,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    PRIMARY KEY(user_id, post_id),  -- composite PK ensures no duplicates
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(post_id) REFERENCES Posts(id) ON DELETE CASCADE
);

CREATE TABLE CommentsVotedOn(
    positive BOOLEAN NOT NULL,
    user_id INT NOT NULL,
    comment_id INT NOT NULL,
    PRIMARY KEY(user_id, comment_id),  -- composite PK ensures no duplicates
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(comment_id) REFERENCES Comments(id) ON DELETE CASCADE
);

-- TRIGGERS

DELIMITER //

CREATE TRIGGER after_subscribe
AFTER INSERT ON SubscribesTo
FOR EACH ROW
BEGIN
    UPDATE Subs
    SET subscriber_count = subscriber_count + 1
    WHERE id = NEW.sub_id;
END//

CREATE TRIGGER after_unsubscribe
AFTER DELETE ON SubscribesTo
FOR EACH ROW
BEGIN
    UPDATE Subs
    SET subscriber_count = subscriber_count - 1
    WHERE id = OLD.sub_id;
END//

CREATE TRIGGER prevent_created_update
BEFORE UPDATE ON Comments
FOR EACH ROW
BEGIN
    SET NEW.created_at = OLD.created_at;
END//

CREATE TRIGGER set_comment_ref
AFTER INSERT ON Comments
FOR EACH ROW
BEGIN
    UPDATE Comments
    SET comment_ref = LOWER(CONV(NEW.id, 10, 36))
    WHERE id = NEW.id;
END//

DELIMITER ;
