-- Making table
DROP TABLE consumption;

CREATE TABLE consumption
(
	country_name VARCHAR(50),
	beer_servings REAL,
	spirit_servings REAL,
	wine_servings REAL,
	total_litres_of_pure_alcohol REAL

);

COPY consumption 
FROM 'C:\Users\User\Desktop\alcohol_production\drinks.csv' 
WITH (FORMAT CSV, HEADER);


-- Selecting first five rows of consumption table
SELECT *
  FROM consumption
 LIMIT 5;

-- Selecting the maximal and the minimal values
SELECT MAX(total_litres_of_pure_alcohol), MIN(total_litres_of_pure_alcohol)
  FROM consumption;

-- Now im going to connect the data from the happiness table
-- with the alcohol consumption table


SELECT *
FROM happiness2021
INNER JOIN consumption
ON happiness2021.country_name = consumption.country_name;


-- Load the joined table


\COPY alcohol_happiness 
FROM 'C:\Users\User\Desktop\alcohol_and_happiness.csv' 
WITH (FORMAT CSV, HEADER);


DROP TABLE alcohol_happiness;
CREATE TABLE alcohol_happiness
(
 	country_name VARCHAR(50),
	regional_indicator VARCHAR(50),
	total_happiness REAL,
	country_name_2 VARCHAR(50),
	beer_servings VARCHAR(50),
	spirit_servings	REAL,
	wine_servings REAL,
	total_literes_of_pure_alcohol REAL
	
);


SELECT *
  FROM alcohol_happiness;
  
  
-- Droping redundant columns
ALTER TABLE alcohol_happiness
DROP COLUMN country_name_2;


SELECT CORR(total_happiness,total_litres_of_pure_alcohol)
  FROM alcohol_happiness;

