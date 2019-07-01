USE twitter_clone;

#Creating Table user
	
	CREATE TABLE users(
			id INT AUTO_INCREMENT PRIMARY KEY,
			username VARCHAR(50),
			created_at TIMESTAMP DEFAULT NOW()
			);
 
#Inserting Data into user table

		INSERT INTO users (username) VALUES ('Gaurav'),('Abhishek'),('Divyansh'),('Guru');

		SELECT * FROM users;

#Creating tweets table
		CREATE TABLE tweets(
			id INT AUTO_INCREMENT PRIMARY KEY,
			body TEXT,
			user_id INT,
			created_at TIMESTAMP DEFAULT NOW(),
			FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
			);
    
		SELECT * FROM tweets;
    
#Inserting Data into tweets table

		INSERT INTO tweets(body,user_id) VALUES ('Its Rainy Season !!',2),
												('Romantic Weather <3',1),
                                                ('Work Mode ONN !!',4),
                                                ('Monday is boring :(',3),
                                                ('Missing School Days',2),
                                                ('Roaming around.',1),
                                                ('New to twitter',3),
                                                ('Narendra Modi our new PM',4);
			
		SELECT * FROM tweets;
            
#Retriving Records using Join

	SELECT 
			users.username,
            tweets.body
	FROM users
	INNER JOIN tweets ON users.id=tweets.user_id ;
    
    
    SELECT 
			users.id,username,
            tweets.body
	FROM users
	INNER JOIN tweets ON users.id=tweets.user_id WHERE users.id IN (1,4) ;
    
    SELECT 
			users.id,username,
            tweets.body
	FROM users
	INNER JOIN tweets ON users.id=tweets.user_id WHERE users.username IN ('Guru','Abhishek') ;
    
    
	SELECT 
			users.id,username,
            tweets.body,created_at
	FROM users
	INNER JOIN tweets ON users.id=tweets.user_id WHERE users.id IN (1,4) ;
    
    SELECT 
			users.id AS UserId,username AS UserName,
            tweets.body AS Tweet,tweets.created_at AS TweetDate
	FROM users
	INNER JOIN tweets ON users.id=tweets.user_id;
    

#Creating Replies Table 
    
		CREATE TABLE replies(
		id INT AUTO_INCREMENT PRIMARY KEY, 
        body TEXT NOT NULL,
        user_id INT, 
        tweet_id INT,
        created_at TIMESTAMP DEFAULT NOW() ,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (tweet_id) REFERENCES tweets(id) ON DELETE CASCADE
        );
        
        SELECT * FROM replies;
        
#Inserting Data into replies table

		INSERT INTO replies (body,user_id,tweet_id)
					VALUES  ('Yeahh!!',3,1),('i love this season',4,1),
							('Best of luck',1,3),('I am doing the same.',3,3),
                            ('Where ??',4,6),('Rohtang Pass,Himachal Pradesh',1,6),
                            ('BJP Rockzz',1,8),('Yeppiiii',3,8),
                            ('Very True :(',1,4),('I hate this day',3,4),
                            ('Lets go somewhere...',2,2),('But its raining outside.',4,2),
                            ('Me tooo..',1,5),('Same here',3,5),
                            ('Happy to see you here..',2,7);
	
#Retriving Data Using Join-- User>>Many Replies

		SELECT
				users.username AS 'User Name',
                tweets.body AS 'Tweet',
                replies.body AS 'Reply'
		FROM replies
        JOIN users ON replies.user_id=users.id
        JOIN tweets ON replies.tweet_id=tweets.id;
        
        
#Reply on particular tweet
		SELECT 
				tweets.body AS 'Tweet',
                replies.body AS 'Reply'
		FROM tweets
        JOIN replies ON replies.tweet_id=tweets.id;
        
        SELECT 
                tweets.body AS 'Tweet',
                replies.body AS 'Reply',
                users.username AS 'User'
		FROM tweets
        JOIN replies ON replies.tweet_id=tweets.id
        JOIN users ON replies.user_id=users.id ORDER BY tweets.body ASC;
					

#Creating Likes Table

		CREATE TABLE likes (
        tweet_id INT, 
        user_id INT,
        FOREIGN KEY (tweet_id) REFERENCES tweets(id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        PRIMARY KEY(user_id,tweet_id)	#User Likes a tweet only one time
        );
        
#Inserting Data into Likes Table

		INSERT INTO likes (tweet_id,user_id)
					VALUES (8,2),(8,1),
							(1,4),(8,3),
                            (8,4),(3,1),
                            (5,2),(5,4);
    
#Selecting Data from likes table
	SELECT * FROM likes;
    
    SELECT 
		COUNT(likes.tweet_id) AS 'Likes',
        tweets.body
	FROM likes
    JOIN tweets ON likes.tweet_id=tweets.id GROUP BY likes.tweet_id;
    
    
    