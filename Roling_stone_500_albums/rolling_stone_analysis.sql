COPY rolling_stone 
FROM 'albumlist.csv' 
WITH (FORMAT CSV, HEADER);

  DROP TABLE rolling_stone; 
CREATE TABLE rolling_stone(
number SERIAL,
  year INT,
 album VARCHAR(200),
artist VARCHAR(200),
 genre VARCHAR(200),
subgenre VARCHAR(200)
);


-- Selecting the first 5 values
SELECT *
  FROM rolling_stone
 LIMIT 5;
 
 
--  Selecting all the uniqe values froom the genre column
SELECT DISTINCT genre
  FROM rolling_stone;
  
  
  -- Selecting top 10 artists by the count of the albums they made
SELECT count(artist) as albums_count, artist
  FROM rolling_stone
 GROUP BY artist
 ORDER BY COUNT(artist) DESC
 LIMIT 10;
 

-- Selecting album count  in ascending order and group it by the year
SELECT count(artist) AS albums_per_year,year
  FROM rolling_stone
 GROUP BY year
 ORDER BY albums_per_year DESC;


-- Selecting and goruping the albums count by the genre
SELECT COUNT(artist) AS albums_per_genre, genre
  FROM rolling_stone
 GROUP BY genre
 ORDER BY albums_per_genre DESC;
 
 
-- Selecting number of uniqe subgenres
SELECT COUNT(DISTINCT(subgenre))
  FROM rolling_stone;
  

-- There's 290 unique subgenres
SELECT subgenre, count(album) AS album_count
  FROM rolling_stone
 GROUP BY subgenre
 ORDER BY album_count DESC;


-- We can see that the most subgenres have the null
-- value