-- Creating table and setting columns
DROP TABLE IF exists happiness2021;


CREATE TABLE happiness2021
(country_name VARCHAR(50),
regional_indicator VARCHAR(50),
ladder_score REAL,
standard_error_of_ladder_score REAL,
upperwhisker REAL,
lowerwhisker REAL,
gdp_per_capita REAL,
social_support REAL,
healthy_life_expectancy REAL,
freedom_to_make_life_choices REAL,
generosity REAL,
perceptions_of_corruption REAL,
ladder_score_in_dystopia REAL,
Log_GDP_per_capita_explained REAL,
social_support_explained REAL,
healthy_life_expectancy_explained REAL,
freedom_to_make_life_choices_explained REAL,
generosity_explained REAL,
perceptions_of_corruption_explained REAL,
dystopia_and_residual REAL);


COPY happiness2021 
FROM 'world-happiness-report-2021.csv' 
WITH (FORMAT CSV, HEADER);


-- Selecting the first five rows
SELECT *
  FROM happiness2021
 LIMIT 5;
 
 
 -- Removing redundant columns from the table
 ALTER TABLE happiness2021
  DROP COLUMN ladder_score,
  DROP COLUMN standard_error_of_ladder_score,
  DROP COLUMN upperwhisker,
  DROP COLUMN lowerwhisker,
  DROP COLUMN ladder_score_in_dystopia
 ;
 
 
 -- Selecting the countries in order to gdp per capita in descending order
 SELECT country_name, gdp_per_capita
   FROM happiness2021
  ORDER BY gdp_per_capita DESC;
 
 
-- selecting the biggest and the lowest gdp per capita
SELECT MAX(gdp_per_capita) AS maximal_gdp_per_capita, MIN(gdp_per_capita) as minimal_gdp_per_capita
  FROM happiness2021;
 
 
-- maximal gdp per capita is equal 11.647 and minimal 6.635, 
-- let's seethe countries which have this score
SELECT *
  FROM happiness2021
 WHERE gdp_per_capita >= 11.64 or gdp_per_capita <= 6.7;
 
 
-- Next step is grouping the countries by regional_indicator and
-- look at the average healthy life expentancy
SELECT regional_indicator , AVG(healthy_life_expectancy) as average
  FROM happiness2021
 GROUP BY regional_indicator
 ORDER BY average DESC;
 -- Next step is making the total_happiness column
 ALTER TABLE happiness2021 
 ADD COLUMN total_happiness REAL;
 

-- Updating all the values in total_happiness column
-- set them to the sum of the columns below
UPDATE happiness2021 SET 
       total_happiness = 
           social_support_explained + 
           healthy_life_expectancy_explained + 
           freedom_to_make_life_choices_explained+ 
      	   log_gdp_per_capita_explained;


-- Now we re going to drop the columns we don't need anymore
 ALTER TABLE happiness2021
  DROP COLUMN social_support_explained,
  DROP COLUMN healthy_life_expectancy_explained,
  DROP COLUMN freedom_to_make_life_choices_explained,
  DROP COLUMN log_gdp_per_capita_explained,
  DROP COLUMN social_support,
  DROP COLUMN healthy_life_expectancy,
  DROP COLUMN freedom_to_make_life_choices,
  DROP COLUMN generosity,
  DROP COLUMN generosity_explained,
  DROP COLUMN perceptions_of_corruption,
  DROP COLUMN dystopia_and_residual,
  DROP COLUMN perceptions_of_corruption_explained,
  DROP COLUMN gdp_per_capita;


-- Now the whole table looks much more clearer
 SELECT *
   FROM happiness2021;


-- Selecting the top 3 the most happies coutries
SELECT MAX(total_happiness)
  FROM happiness2021;


SELECT *
  FROM happiness2021
 ORDER BY total_happiness DESC
 LIMIT 3;
 
 
 -- Selecting the 3 most sadest countries
 SELECT *
  FROM happiness2021
 ORDER BY total_happiness
 LIMIT 3;
 
 
-- Grouping the country names by the regional_indicator
-- and sum all of total happiness
SELECT regional_indicator,  AVG(total_happiness) AS average_happiness
  FROM happiness2021
 GROUP BY regional_indicator
 ORDER BY average_happiness DESC;
 
 
-- Selecting the happiness score for Poland
SELECT *
  FROM happiness2021
 WHERE country_name = 'Poland';