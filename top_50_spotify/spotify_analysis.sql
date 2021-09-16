-- Making table
DROP TABLE spotify;


CREATE TABLE spotify(
	id INT,
	track_name VARCHAR(100),	
	artist_name VARCHAR(100),	
	genre VARCHAR(100),	
	bpms SMALLINT,
	energy	SMALLINT,
	danceability SMALLINT,	
	loudness_in_db SMALLINT,	
	liveness SMALLINT,	
	valence SMALLINT,	
	length SMALLINT,	
	acousticness SMALLINT,	
	speechiness SMALLINT,	
	popularity SMALLINT
);


-- Inserting data into the table
\COPY spotify  
FROM 'C:\Users\User\Desktop\top50.csv'  
WITH (FORMAT CSV, HEADER);


-- Selecting first five rows
SELECT *
  FROM spotify
 LIMIT 5;


-- Droping redundant columns
ALTER TABLE spotify
 DROP COLUMN id;


-- Select the most frequent genres
SELECT COUNT(genre) AS frequency, genre
  FROM spotify
 GROUP BY genre
 ORDER BY frequency DESC;


-- We can see that the most frequent is dance pop
-- Next step is to set the cause when the genre is
-- equal to dance pop and see the artists

SELECT *
  FROM spotify
 WHERE genre = 'dance pop';
 
 
-- Now we re going to examine the most frequent artist
-- occurences on this list, im going to see if
-- he/she produce dance pop as well
SELECT COUNT(artist_name) AS frequency, artist_name
  FROM spotify
 GROUP BY (artist_name)
 ORDER BY frequency DESC;


-- We can see that Ed Sheeran is at the top in this case,
-- let's examine if he produces dance pop as well

SELECT *
  FROM spotify
 WHERE artist_name = 'Ed Sheeran';
 -- We can see that in this case the genre is pop ,
 -- not dance pop
 
 
 -- Next thing we re going to do is to group the 
 -- songs by popularity
 
 SELECT  count(popularity), popularity
   FROM spotify
  GROUP BY popularity
  ORDER BY popularity DESC;
  
 -- The most songs have the popularity scale between 88 and 94
 -- We re going to select the average bmps (beats per minute)
 SELECT ROUND(AVG(BPMS))
   FROM spotify
  WHERE popularity BETWEEN 88 AND 94;
  
 
-- we re going to select the avg bmps for all songs as well
   SELECT ROUND(AVG(BPMS))
   FROM spotify;
 

-- Let's see the correlation between bpms and popularity
SELECT corr(bpms, popularity)
  FROM spotify;
-- weak correlation 0.2 occures


-- Bpms mean for all is equal 120, i m going to set the new column
-- mean_bpm and calculate the MAE - Mean Absolute Error
ALTER TABLE spotify
 ADD COLUMN mean_bpms SMALLINT;


UPDATE spotify
   SET mean_bpms = 120;


ALTER TABLE spotify
  ADD COLUMN mae REAL;
 
 
 UPDATE spotify
    SET mae = ABS(mean_bpms - bpms);


ALTER TABLE spotify
 DROP COLUMN mean_bpms;

 
-- Selecting top 50 spotify songs which have 120 +30/-30 bpms;
SELECT COUNT(*)
 FROM spotify
 WHERE mae < 30;
-- There's 36 from 50 songs which follow this rule.


-- ***CONSLUSIONS***
-- Conclusions are quite clear:
-- - The most popular genre is dance pop
-- - The most popular artist is Ed Sheeran and his songs are classified as pop
-- - You have more chance when your song is classified as pop / dance pop and bpms of your song are not
-- bigger than 150 or 90
-- ***CONCLUSIONS***