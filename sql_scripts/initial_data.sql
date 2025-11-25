USE goddit_db;

INSERT INTO Users (username, email, password, role, created)
VALUES
('Goddit', 'admin@goddit.com', 'securepassword', 'admin', NOW()),
('john_doe', 'john.doe@example.com', 'password123', 'user', NOW() - INTERVAL 10 DAY),
('jane_doe', 'jane.doe@example.com', 'password123', 'user', NOW() - INTERVAL 20 DAY),
('alice', 'alice@example.com', 'password123', 'user', NOW() - INTERVAL 15 DAY),
('bob', 'bob@example.com', 'password123', 'user', NOW() - INTERVAL 5 DAY),
('charlie', 'charlie@example.com', 'password123', 'user', NOW() - INTERVAL 30 DAY),
('david', 'david@example.com', 'password123', 'user', NOW() - INTERVAL 25 DAY),
('eve', 'eve@example.com', 'password123', 'user', NOW() - INTERVAL 12 DAY),
('frank', 'frank@example.com', 'password123', 'user', NOW() - INTERVAL 8 DAY),
('grace', 'grace@example.com', 'password123', 'user', NOW() - INTERVAL 18 DAY),
('hank', 'hank@example.com', 'password123', 'user', NOW() - INTERVAL 22 DAY),
('irene', 'irene@example.com', 'password123', 'user', NOW() - INTERVAL 3 DAY),
('jack', 'jack@example.com', 'password123', 'user', NOW() - INTERVAL 7 DAY),
('karen', 'karen@example.com', 'password123', 'user', NOW() - INTERVAL 14 DAY),
('larry', 'larry@example.com', 'password123', 'user', NOW() - INTERVAL 6 DAY),
('mary', 'mary@example.com', 'password123', 'user', NOW() - INTERVAL 11 DAY),
('nancy', 'nancy@example.com', 'password123', 'user', NOW() - INTERVAL 9 DAY),
('oscar', 'oscar@example.com', 'password123', 'user', NOW() - INTERVAL 4 DAY),
('paul', 'paul@example.com', 'password123', 'user', NOW() - INTERVAL 13 DAY),
('quinn', 'quinn@example.com', 'password123', 'user', NOW() - INTERVAL 2 DAY);

INSERT INTO Sub_goddits (name, description, subscribers, daily_users, created)
VALUES
('TechTalk', 'A place to discuss technology and gadgets.', 500, 120, NOW() - INTERVAL 30 DAY),
('GamingHub', 'All about video games and gaming culture.', 800, 200, NOW() - INTERVAL 25 DAY),
('MovieBuffs', 'Discuss movies, reviews, and recommendations.', 300, 80, NOW() - INTERVAL 20 DAY),
('FitnessFreaks', 'Health, fitness, and workout tips.', 400, 100, NOW() - INTERVAL 15 DAY),
('Foodies', 'Share recipes, food pics, and restaurant reviews.', 600, 150, NOW() - INTERVAL 10 DAY),
('Travelers', 'Travel tips, destinations, and experiences.', 700, 180, NOW() - INTERVAL 5 DAY),
('Programming', 'Discuss coding, software development, and more.', 1000, 250, NOW() - INTERVAL 40 DAY),
('MusicLovers', 'Share and discuss your favorite music.', 450, 110, NOW() - INTERVAL 35 DAY),
('Photography', 'Tips, tricks, and sharing your best shots.', 350, 90, NOW() - INTERVAL 28 DAY),
('BooksAndMore', 'Book reviews, recommendations, and discussions.', 300, 70, NOW() - INTERVAL 22 DAY),
('ScienceNerds', 'Discuss science, research, and discoveries.', 550, 130, NOW() - INTERVAL 18 DAY),
('DIYProjects', 'Share your DIY projects and ideas.', 400, 95, NOW() - INTERVAL 12 DAY),
('Parenting', 'Advice and support for parents.', 250, 60, NOW() - INTERVAL 8 DAY),
('PetsAndAnimals', 'Share your love for pets and animals.', 500, 125, NOW() - INTERVAL 6 DAY),
('HistoryBuffs', 'Discuss history, events, and figures.', 300, 75, NOW() - INTERVAL 14 DAY),
('ArtAndDesign', 'Share and discuss art and design.', 350, 85, NOW() - INTERVAL 11 DAY),
('Entrepreneurs', 'Tips and discussions for entrepreneurs.', 400, 100, NOW() - INTERVAL 9 DAY),
('Memes', 'Share and enjoy memes.', 1000, 300, NOW() - INTERVAL 3 DAY),
('Politics', 'Discuss politics and current events.', 700, 180, NOW() - INTERVAL 7 DAY),
('SportsTalk', 'All about sports and athletes.', 600, 150, NOW() - INTERVAL 4 DAY);


INSERT INTO Posts (title, body, upvotes, downvotes, created, user_id, sub_id)
VALUES
('Best programming languages in 2025', 'What are your thoughts?', 120, 10, NOW() - INTERVAL 1 DAY, 2, 7),
('Top 10 video games of the year', 'Here are my picks...', 200, 15, NOW() - INTERVAL 2 DAY, 3, 2),
('Fitness tips for beginners', 'Start small and stay consistent.', 80, 5, NOW() - INTERVAL 3 DAY, 4, 4),
('Best movies to watch this weekend', 'Check out these recommendations.', 90, 8, NOW() - INTERVAL 4 DAY, 5, 3),
('How to cook the perfect steak', 'Follow these steps...', 150, 12, NOW() - INTERVAL 5 DAY, 6, 5),
('Top travel destinations for 2025', 'Here are some amazing places...', 180, 20, NOW() - INTERVAL 6 DAY, 7, 6),
('Why Python is great for beginners', 'Let me explain...', 250, 18, NOW() - INTERVAL 7 DAY, 8, 7),
('Share your favorite songs', 'I love this playlist...', 110, 9, NOW() - INTERVAL 8 DAY, 9, 8),
('Photography tips for beginners', 'Start with these basics...', 95, 7, NOW() - INTERVAL 9 DAY, 10, 9),
('Best books of the year', 'Here are my top picks...', 70, 6, NOW() - INTERVAL 10 DAY, 11, 10),
('Recent scientific discoveries', 'Check out these amazing findings...', 130, 11, NOW() - INTERVAL 11 DAY, 12, 11),
('DIY home improvement projects', 'Here are some ideas...', 100, 8, NOW() - INTERVAL 12 DAY, 13, 12),
('Parenting tips for new parents', 'Here are some helpful tips...', 60, 5, NOW() - INTERVAL 13 DAY, 14, 13),
('Cute pet pictures', 'Share your pets!', 125, 10, NOW() - INTERVAL 14 DAY, 15, 14),
('Historical events that changed the world', 'Let’s discuss...', 75, 7, NOW() - INTERVAL 15 DAY, 16, 15),
('Amazing art pieces', 'Check out these works...', 85, 6, NOW() - INTERVAL 16 DAY, 17, 16),
('Starting your own business', 'Here’s how...', 100, 9, NOW() - INTERVAL 17 DAY, 18, 17),
('Funniest memes of the week', 'Let’s laugh together...', 300, 20, NOW() - INTERVAL 18 DAY, 19, 18),
('Political debates in 2025', 'What are your thoughts?', 180, 15, NOW() - INTERVAL 19 DAY, 20, 19),
('Top sports moments of the year', 'Here are some highlights...', 150, 12, NOW() - INTERVAL 20 DAY, 2, 20);

INSERT INTO Comments (body, upvotes, downvotes, created_at, user_id, post_id, responds_to)
VALUES
('I completely agree!', 50, 2, NOW() - INTERVAL 1 HOUR, 3, 1, NULL),
('Great list, thanks for sharing!', 40, 1, NOW() - INTERVAL 2 HOUR, 4, 2, NULL),
('This is very helpful.', 30, 0, NOW() - INTERVAL 3 HOUR, 5, 3, NULL),
('I have a different opinion.', 20, 5, NOW() - INTERVAL 4 HOUR, 6, 4, NULL),
('Thanks for the tips!', 25, 1, NOW() - INTERVAL 5 HOUR, 7, 5, NULL),
('Amazing post!', 35, 2, NOW() - INTERVAL 6 HOUR, 8, 6, NULL),
('I learned something new.', 45, 3, NOW() - INTERVAL 7 HOUR, 9, 7, NULL),
('This is so true.', 50, 4, NOW() - INTERVAL 8 HOUR, 10, 8, NULL),
('I disagree with this.', 15, 10, NOW() - INTERVAL 9 HOUR, 11, 9, NULL),
('This is a great resource.', 60, 2, NOW() - INTERVAL 10 HOUR, 12, 10, NULL),
('Interesting perspective.', 40, 3, NOW() - INTERVAL 11 HOUR, 13, 11, NULL),
('I love this!', 55, 1, NOW() - INTERVAL 12 HOUR, 14, 12, NULL),
('This is so helpful.', 35, 2, NOW() - INTERVAL 13 HOUR, 15, 13, NULL),
('I completely disagree.', 10, 20, NOW() - INTERVAL 14 HOUR, 16, 14, NULL),
('Great advice!', 45, 0, NOW() - INTERVAL 15 HOUR, 17, 15, NULL),
('This is amazing.', 50, 1, NOW() - INTERVAL 16 HOUR, 18, 16, NULL),
('I have a question about this.', 30, 5, NOW() - INTERVAL 17 HOUR, 19, 17, NULL),
('This is hilarious!', 70, 2, NOW() - INTERVAL 18 HOUR, 20, 18, NULL),
('I don’t think this is accurate.', 20, 15, NOW() - INTERVAL 19 HOUR, 2, 19, NULL),
('Thanks for sharing!', 60, 3, NOW() - INTERVAL 20 HOUR, 3, 20, NULL);


INSERT INTO Events (title, body, start, end, organisor_id)
VALUES
('Tech Conference 2025', 'A conference about the latest in tech.', NOW() + INTERVAL 2 DAY, NOW() + INTERVAL 3 DAY, 2),
('Gaming Expo', 'Showcasing the latest games and consoles.', NOW() + INTERVAL 5 DAY, NOW() + INTERVAL 6 DAY, 3),
('Movie Night', 'Watch and discuss the latest blockbuster.', NOW() + INTERVAL 1 DAY, NOW() + INTERVAL 1 DAY + INTERVAL 3 HOUR, 4),
('Fitness Bootcamp', 'A day of fitness and health activities.', NOW() + INTERVAL 4 DAY, NOW() + INTERVAL 4 DAY + INTERVAL 6 HOUR, 5),
('Cooking Workshop', 'Learn to cook delicious meals.', NOW() + INTERVAL 3 DAY, NOW() + INTERVAL 3 DAY + INTERVAL 4 HOUR, 6),
('Travel Meetup', 'Share travel stories and tips.', NOW() + INTERVAL 7 DAY, NOW() + INTERVAL 7 DAY + INTERVAL 5 HOUR, 7),
('Programming Hackathon', 'Compete in coding challenges.', NOW() + INTERVAL 6 DAY, NOW() + INTERVAL 6 DAY + INTERVAL 8 HOUR, 8),
('Music Festival', 'Enjoy live music performances.', NOW() + INTERVAL 10 DAY, NOW() + INTERVAL 11 DAY, 9),
('Photography Walk', 'Capture amazing photos together.', NOW() + INTERVAL 8 DAY, NOW() + INTERVAL 8 DAY + INTERVAL 3 HOUR, 10),
('Book Club Meeting', 'Discuss the latest book.', NOW() + INTERVAL 2 DAY, NOW() + INTERVAL 2 DAY + INTERVAL 2 HOUR, 11),
('Science Fair', 'Explore exciting science projects.', NOW() + INTERVAL 9 DAY, NOW() + INTERVAL 9 DAY + INTERVAL 6 HOUR, 12),
('DIY Workshop', 'Learn new DIY skills.', NOW() + INTERVAL 3 DAY, NOW() + INTERVAL 3 DAY + INTERVAL 5 HOUR, 13),
('Parenting Seminar', 'Tips and advice for parents.', NOW() + INTERVAL 4 DAY, NOW() + INTERVAL 4 DAY + INTERVAL 3 HOUR, 14),
('Pet Adoption Event', 'Find your new furry friend.', NOW() + INTERVAL 5 DAY, NOW() + INTERVAL 5 DAY + INTERVAL 4 HOUR, 15),
('History Lecture', 'Learn about historical events.', NOW() + INTERVAL 6 DAY, NOW() + INTERVAL 6 DAY + INTERVAL 2 HOUR, 16),
('Art Exhibition', 'View amazing art pieces.', NOW() + INTERVAL 7 DAY, NOW() + INTERVAL 7 DAY + INTERVAL 4 HOUR, 17),
('Startup Pitch Night', 'Pitch your startup idea.', NOW() + INTERVAL 8 DAY, NOW() + INTERVAL 8 DAY + INTERVAL 3 HOUR, 18),
('Meme Contest', 'Share and vote on the funniest memes.', NOW() + INTERVAL 9 DAY, NOW() + INTERVAL 9 DAY + INTERVAL 2 HOUR, 19),
('Political Debate', 'Discuss current political issues.', NOW() + INTERVAL 10 DAY, NOW() + INTERVAL 10 DAY + INTERVAL 5 HOUR, 20),
('Sports Day', 'Participate in fun sports activities.', NOW() + INTERVAL 11 DAY, NOW() + INTERVAL 11 DAY + INTERVAL 6 HOUR, 2);


INSERT INTO Event_participations (event_id, user_id)
VALUES
(1, 3), (1, 4), (1, 5), (1, 6), (1, 7),
(2, 8), (2, 9), (2, 10), (2, 11), (2, 12),
(3, 13), (3, 14), (3, 15), (3, 16), (3, 17),
(4, 18), (4, 19), (4, 20), (4, 2), (4, 3),
(5, 4), (5, 5), (5, 6), (5, 7), (5, 8),
(6, 9), (6, 10), (6, 11), (6, 12), (6, 13),
(7, 14), (7, 15), (7, 16), (7, 17), (7, 18),
(8, 19), (8, 20), (8, 2), (8, 3), (8, 4);


INSERT INTO Message_chains ()
VALUES (), (), (), (), (), (), (), (), (), (),
       (), (), (), (), (), (), (), (), (), ();


INSERT INTO Message_chain_participants (user_id, chain_id, has_read, read_only)
VALUES
(3, 1, FALSE, FALSE), (4, 1, FALSE, FALSE), (5, 1, FALSE, FALSE),
(6, 2, FALSE, FALSE), (7, 2, FALSE, FALSE), (8, 2, FALSE, FALSE),
(9, 3, FALSE, FALSE), (10, 3, FALSE, FALSE), (11, 3, FALSE, FALSE),
(12, 4, FALSE, FALSE), (13, 4, FALSE, FALSE), (14, 4, FALSE, FALSE),
(15, 5, FALSE, FALSE), (16, 5, FALSE, FALSE), (17, 5, FALSE, FALSE),
(18, 6, FALSE, FALSE), (19, 6, FALSE, FALSE), (20, 6, FALSE, FALSE),
(2, 7, FALSE, FALSE), (3, 7, FALSE, FALSE);

INSERT INTO Messages (body, sent, sender_id, chain_id)
VALUES
('Welcome to the event discussion!', NOW() - INTERVAL 1 DAY, 3, 1),
('Looking forward to this event!', NOW() - INTERVAL 1 DAY, 4, 1),
('Can’t wait to meet everyone!', NOW() - INTERVAL 2 DAY, 6, 2),
('What time does the event start?', NOW() - INTERVAL 2 DAY, 7, 2),
('This is going to be fun!', NOW() - INTERVAL 3 DAY, 9, 3),
('Any tips for first-time attendees?', NOW() - INTERVAL 3 DAY, 10, 3),
('I’m excited to join this event!', NOW() - INTERVAL 4 DAY, 12, 4),
('Let’s make this a great event!', NOW() - INTERVAL 4 DAY, 13, 4),
('What’s the dress code for the event?', NOW() - INTERVAL 5 DAY, 15, 5),
('Looking forward to the discussions!', NOW() - INTERVAL 5 DAY, 16, 5),
('This is my first time attending.', NOW() - INTERVAL 6 DAY, 18, 6),
('Can we bring guests to the event?', NOW() - INTERVAL 6 DAY, 19, 6),
('What’s the agenda for the event?', NOW() - INTERVAL 7 DAY, 2, 7),
('I hope to learn a lot from this event.', NOW() - INTERVAL 7 DAY, 3, 7);

INSERT INTO Subscriptions (user_id, sub_id, subscribed_at, user_flair_id)
VALUES
(2, 1, NOW() - INTERVAL 10 DAY, NULL),
(3, 1, NOW() - INTERVAL 8 DAY, NULL),
(4, 2, NOW() - INTERVAL 15 DAY, NULL),
(5, 2, NOW() - INTERVAL 12 DAY, NULL),
(6, 3, NOW() - INTERVAL 20 DAY, NULL),
(7, 3, NOW() - INTERVAL 18 DAY, NULL),
(8, 4, NOW() - INTERVAL 25 DAY, NULL),
(9, 4, NOW() - INTERVAL 22 DAY, NULL),
(10, 5, NOW() - INTERVAL 30 DAY, NULL),
(11, 5, NOW() - INTERVAL 28 DAY, NULL),
(12, 6, NOW() - INTERVAL 5 DAY, NULL),
(13, 6, NOW() - INTERVAL 3 DAY, NULL),
(14, 7, NOW() - INTERVAL 7 DAY, NULL),
(15, 7, NOW() - INTERVAL 6 DAY, NULL),
(16, 8, NOW() - INTERVAL 9 DAY, NULL),
(17, 8, NOW() - INTERVAL 8 DAY, NULL),
(18, 9, NOW() - INTERVAL 11 DAY, NULL),
(19, 9, NOW() - INTERVAL 10 DAY, NULL),
(20, 10, NOW() - INTERVAL 13 DAY, NULL),
(2, 10, NOW() - INTERVAL 12 DAY, NULL);


INSERT INTO Post_votes (is_upvote, user_id, post_id)
VALUES
(TRUE, 2, 1), (TRUE, 3, 1), (FALSE, 4, 1), (TRUE, 5, 1), (TRUE, 6, 1),
(TRUE, 7, 2), (FALSE, 8, 2), (TRUE, 9, 2), (TRUE, 10, 2), (FALSE, 11, 2),
(TRUE, 12, 3), (TRUE, 13, 3), (FALSE, 14, 3), (TRUE, 15, 3), (TRUE, 16, 3),
(FALSE, 17, 4), (TRUE, 18, 4), (TRUE, 19, 4), (TRUE, 20, 4), (TRUE, 2, 4),
(TRUE, 3, 5), (TRUE, 4, 5), (FALSE, 5, 5), (TRUE, 6, 5), (TRUE, 7, 5),
(TRUE, 8, 6), (TRUE, 9, 6), (FALSE, 10, 6), (TRUE, 11, 6), (TRUE, 12, 6),
(TRUE, 13, 7), (TRUE, 14, 7), (FALSE, 15, 7), (TRUE, 16, 7), (TRUE, 17, 7),
(FALSE, 18, 8), (TRUE, 19, 8), (TRUE, 20, 8), (TRUE, 2, 8), (TRUE, 3, 8),
(TRUE, 4, 9), (TRUE, 5, 9), (FALSE, 6, 9), (TRUE, 7, 9), (TRUE, 8, 9),
(TRUE, 9, 10), (TRUE, 10, 10), (FALSE, 11, 10), (TRUE, 12, 10), (TRUE, 13, 10);


INSERT INTO Comment_votes (positive, user_id, comment_id)
VALUES
(TRUE, 2, 1), (TRUE, 3, 1), (FALSE, 4, 1), (TRUE, 5, 1), (TRUE, 6, 1),
(TRUE, 7, 2), (FALSE, 8, 2), (TRUE, 9, 2), (TRUE, 10, 2), (FALSE, 11, 2),
(TRUE, 12, 3), (TRUE, 13, 3), (FALSE, 14, 3), (TRUE, 15, 3), (TRUE, 16, 3),
(FALSE, 17, 4), (TRUE, 18, 4), (TRUE, 19, 4), (TRUE, 20, 4), (TRUE, 2, 4),
(TRUE, 3, 5), (TRUE, 4, 5), (FALSE, 5, 5), (TRUE, 6, 5), (TRUE, 7, 5),
(TRUE, 8, 6), (TRUE, 9, 6), (FALSE, 10, 6), (TRUE, 11, 6), (TRUE, 12, 6),
(TRUE, 13, 7), (TRUE, 14, 7), (FALSE, 15, 7), (TRUE, 16, 7), (TRUE, 17, 7),
(FALSE, 18, 8), (TRUE, 19, 8), (TRUE, 20, 8), (TRUE, 2, 8), (TRUE, 3, 8),
(TRUE, 4, 9), (TRUE, 5, 9), (FALSE, 6, 9), (TRUE, 7, 9), (TRUE, 8, 9),
(TRUE, 9, 10), (TRUE, 10, 10), (FALSE, 11, 10), (TRUE, 12, 10), (TRUE, 13, 10),
(TRUE, 14, 11), (TRUE, 15, 11), (FALSE, 16, 11), (TRUE, 17, 11), (TRUE, 18, 11),
(FALSE, 19, 12), (TRUE, 20, 12), (TRUE, 2, 12), (TRUE, 3, 12), (TRUE, 4, 12),
(TRUE, 5, 13), (TRUE, 6, 13), (FALSE, 7, 13), (TRUE, 8, 13), (TRUE, 9, 13),
(TRUE, 10, 14), (TRUE, 11, 14), (FALSE, 12, 14), (TRUE, 13, 14), (TRUE, 14, 14),
(TRUE, 15, 15), (TRUE, 16, 15), (FALSE, 17, 15), (TRUE, 18, 15), (TRUE, 19, 15);


INSERT INTO Moderators (user_id, sub_id, role)
VALUES
(2, 1, 'owner'),
(3, 1, 'moderator'),
(4, 2, 'owner'),
(5, 2, 'moderator'),
(6, 3, 'owner'),
(7, 3, 'moderator'),
(8, 4, 'owner'),
(9, 4, 'moderator'),
(10, 5, 'owner'),
(11, 5, 'moderator'),
(12, 6, 'owner'),
(13, 6, 'moderator'),
(14, 7, 'owner'),
(15, 7, 'moderator'),
(16, 8, 'owner'),
(17, 8, 'moderator'),
(18, 9, 'owner'),
(19, 9, 'moderator'),
(20, 10, 'owner'),
(2, 10, 'moderator');

INSERT INTO Award_types (name)
VALUES
('Gold'),
('Silver'),
('Bronze'),
('Platinum'),
('Diamond'),
('Ruby'),
('Emerald'),
('Sapphire'),
('Top Contributor'),
('Helpful'),
('Funny'),
('Insightful'),
('Creative'),
('Supportive'),
('Innovative'),
('Kind'),
('Generous'),
('Leader'),
('Visionary'),
('Legendary');

INSERT INTO Purchases (amount_paid, gold_recieved, user_id)
VALUES
(9.99, 100, 2),
(19.99, 250, 3),
(4.99, 50, 4),
(49.99, 500, 5),
(99.99, 1000, 6),
(14.99, 150, 7),
(29.99, 300, 8),
(19.99, 250, 9),
(9.99, 100, 10),
(49.99, 500, 11),
(99.99, 1000, 12),
(4.99, 50, 13),
(14.99, 150, 14),
(29.99, 300, 15),
(19.99, 250, 16),
(9.99, 100, 17),
(49.99, 500, 18),
(99.99, 1000, 19),
(4.99, 50, 20),
(14.99, 150, 2);


INSERT INTO Archived_Posts (id, title, body, upvotes, downvotes, created, user_id, sub_id)
VALUES
(1, 'Best programming languages in 2025', 'What are your thoughts?', 120, 10, NOW() - INTERVAL 365 DAY, 2, 7),
(2, 'Top 10 video games of the year', 'Here are my picks...', 200, 15, NOW() - INTERVAL 400 DAY, 3, 2),
(3, 'Fitness tips for beginners', 'Start small and stay consistent.', 80, 5, NOW() - INTERVAL 370 DAY, 4, 4),
(4, 'Best movies to watch this weekend', 'Check out these recommendations.', 90, 8, NOW() - INTERVAL 380 DAY, 5, 3),
(5, 'How to cook the perfect steak', 'Follow these steps...', 150, 12, NOW() - INTERVAL 390 DAY, 6, 5),
(6, 'Top travel destinations for 2024', 'Here are some amazing places...', 180, 20, NOW() - INTERVAL 450 DAY, 7, 6),
(7, 'Why Python is great for beginners', 'Let me explain...', 250, 18, NOW() - INTERVAL 500 DAY, 8, 7),
(8, 'Share your favorite songs', 'I love this playlist...', 110, 9, NOW() - INTERVAL 420 DAY, 9, 8),
(9, 'Photography tips for beginners', 'Start with these basics...', 95, 7, NOW() - INTERVAL 430 DAY, 10, 9),
(10, 'Best books of the year', 'Here are my top picks...', 70, 6, NOW() - INTERVAL 440 DAY, 11, 10);


INSERT INTO Comment_awards (user_id, comment_id, award_id)
VALUES
(2, 1, 1), (3, 2, 2), (4, 3, 3), (5, 4, 4), (6, 5, 5),
(7, 6, 6), (8, 7, 7), (9, 8, 8), (10, 9, 9), (11, 10, 10);


INSERT INTO Post_flairs (body, sub_id)
VALUES
('Discussion', 1),
('Question', 2),
('News', 3),
('Guide', 4),
('Opinion', 5),
('Tutorial', 6),
('Review', 7),
('Announcement', 8),
('Poll', 9),
('Event', 10);


INSERT INTO Post_awards (user_id, post_id, award_id)
VALUES
(2, 1, 1), (3, 2, 2), (4, 3, 3), (5, 4, 4), (6, 5, 5),
(7, 6, 6), (8, 7, 7), (9, 8, 8), (10, 9, 9), (11, 10, 10);


INSERT INTO User_activity (user_id, sub_id, time_visited)
VALUES
(2, 1, NOW() - INTERVAL 1 HOUR),
(3, 2, NOW() - INTERVAL 2 HOUR),
(4, 3, NOW() - INTERVAL 3 HOUR),
(5, 4, NOW() - INTERVAL 4 HOUR),
(6, 5, NOW() - INTERVAL 5 HOUR),
(7, 6, NOW() - INTERVAL 6 HOUR),
(8, 7, NOW() - INTERVAL 7 HOUR),
(9, 8, NOW() - INTERVAL 8 HOUR),
(10, 9, NOW() - INTERVAL 9 HOUR),
(11, 10, NOW() - INTERVAL 10 HOUR);


INSERT INTO User_flairs (body, sub_id)
VALUES
('Tech Enthusiast', 1),
('Gamer', 2),
('Movie Buff', 3),
('Fitness Guru', 4),
('Food Lover', 5),
('Traveler', 6),
('Programmer', 7),
('Music Fan', 8),
('Photographer', 9),
('Bookworm', 10);