-- Look over all columns in the table
SELECT 
    *
FROM
    rank_by_year;

-- What is the range of column "year"?
SELECT 
    MIN(year), MAX(year)
FROM
    rank_by_year;
-- Answer: We see that "year" has a range from 2006 to 2025.

-- How many countries are in this table?
SELECT 
    COUNT(DISTINCT country) AS numb_country
FROM
    rank_by_year;
-- Answer: There are 171 countries in the data table. 

SELECT 
    country, COUNT(*) AS count
FROM
    rank_by_year
GROUP BY country;
-- Observation: Majority of the countries have 20 with some have 18 and one has 13. Let find the exact number of countries. COMEBACK

 
-- How many countries are in each region?
SELECT 
    region, COUNT(DISTINCT country) AS numb_country
FROM
    rank_by_year
GROUP BY region
ORDER BY numb_country DESC;
-- Answer: Africa has the highest number of countries with 49 countries and Oceania has the lowest number of countries with 11 countries.

-- What is the range of "rank"?
SELECT 
    MIN(strength), MAX(strength)
FROM
    rank_by_year;
-- Answer: The range of "rank" is from 1 to 116. The lowest rank is 1 and highest rank is 116. 

-- What is the range of the column "visa_free_count"?
SELECT 
    MIN(visa_free_count), MAX(visa_free_count)
FROM
    rank_by_year;
-- Answer: The range of "visa_free_count" is from 0 to 194. 
-- This means countries with value of 0 in column "visa_free_count" have weak passports that require visas and/or other documentations to travel to other countries.
-- On the other hand, value 194 represents very strong passports that can travel to other countries visa free/.

-- Which country has the highest rank? Which one has the lowest rank in each year?
SELECT 
    year, MAX(strength), MAX(visa_free_count)
FROM
    rank_by_year
GROUP BY year
ORDER BY year;

SELECT 
    year, MIN(strength), MIN(visa_free_count)
FROM
    rank_by_year
GROUP BY year
ORDER BY year;

-- What countries are in the top 5, lowest 5 overall, in each region, in each year?
SELECT 
    country, strength, year
FROM
    rank_by_year
ORDER BY strength , year;

SELECT 
    country, strength, year
FROM
    rank_by_year
ORDER BY year , strength DESC;

-- Which country's passport has the most counts of visa free? Which has the least in each year?
SELECT 
    country, visa_free_count, year
FROM
    rank_by_year
ORDER BY visa_free_count , year;

SELECT 
    country, visa_free_count, year
FROM
    rank_by_year
ORDER BY year DESC , visa_free_count DESC;
-- In 2025, the top 5 countries with the most visa free count are Singapore, South Korea, Japan, Ireland, and Denmark. 
CREATE VIEW country_tbl AS
    SELECT 
        country, visa_free_count, year
    FROM
        rank_by_year;

-- Can we get most visa free count countries for each year?
SELECT 
    year, 
    country, 
    visa_free_count,
    count(*) over(partition by year) as country_count
FROM
    (select year, country, visa_free_count,
    rank() over(partition by year order by visa_free_count desc) as ranking from rank_by_year) rank_tbl
    where ranking = 1 and year != 2007 and year != 2009
ORDER BY year;
-- Answer: The output shows the strongest passport from each year except 2007 and 2009. Further observation shows that there are years where a couple of countries have a tie for the strongest passport of the year.
-- We see that in 2024, there are 6 countries (France, Germany, Italy, Japan, Singapore, and Spain) ranked first, making 2024 the year with the most countries with ties. 

-- What is the average visa_free_count in each region?
SELECT 
    region, ROUND(AVG(visa_free_count), 0) AS avg_rank
FROM
    rank_by_year
GROUP BY region
ORDER BY avg_rank DESC;
-- Answer: We see that Europe is leading with the highest counts of visa free with an average counts of 131 while Africa has the least counts of visa free for a passport holder.

-- What is the average visa_free_count in each year?
SELECT 
    year, ROUND(AVG(visa_free_count), 0) AS avg_rank
FROM
    rank_by_year
GROUP BY year
ORDER BY year;
-- Answer: We notice 2007 and 2009 have average rank of 0, so let's take a closer look into that!

SELECT 
    *
FROM
    rank_by_year
WHERE
    year = 2007;
    
SELECT 
    *
FROM
    rank_by_year
WHERE
    year = 2009;
-- Answer: We see that in 2007 and 2009, there are no records of visa-free counts for all the countries. However, all other columns still have data.



