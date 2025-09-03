create database google_playstore_analysis;
use google_playstore_analysis;
SHOW COLUMNS FROM googleplaystore;

-- identifying null values--
SELECT 
  SUM(App IS NULL OR App = '' OR App = 'NaN') AS App_missing,
  SUM(Category IS NULL OR Category = '' OR Category = 'NaN') AS Category_missing,
  SUM(Rating IS NULL OR Rating = '' OR Rating = 'NaN') AS Rating_missing,
  SUM(Reviews IS NULL OR Reviews = '' OR Reviews = 'NaN') AS Reviews_missing,
  SUM(Size IS NULL OR Size = '' OR Size = 'NaN') AS Size_missing,
  SUM(Installs IS NULL OR Installs = '' OR Installs = 'NaN') AS Installs_missing,
  SUM(Type IS NULL OR Type = '' OR Type = 'NaN') AS Type_missing,
  SUM(Price IS NULL OR Price = '' OR Price = 'NaN') AS Price_missing,
  SUM(`Content Rating` IS NULL OR `Content Rating` = '' OR `Content Rating` = 'NaN') AS ContentRating_missing,
  SUM(Genres IS NULL OR Genres = '' OR Genres = 'NaN') AS Genres_missing,
  SUM(`Last Updated` IS NULL OR `Last Updated` = '' OR `Last Updated` = 'NaN') AS LastUpdated_missing,
  SUM(`Current Ver` IS NULL OR `Current Ver` = '' OR `Current Ver` = 'NaN') AS CurrentVer_missing,
  SUM(`Android Ver` IS NULL OR `Android Ver` = '' OR `Android Ver` = 'NaN') AS AndroidVer_missing
FROM googleplaystore;

-- over all view of dataset --
SELECT 
    COUNT(DISTINCT TRIM(App)) AS TOTAL_APPS,
    COUNT(DISTINCT TRIM(Category)) AS TOTAL_CATEGORIES
FROM googleplaystore;

SELECT COUNT(*) AS total_rows FROM googleplaystore;

-- explroe app categories --
SELECT 
CATEGORY,
COUNT(APP) AS TOTALAPP
FROM GOOGLEPLAYSTORE
GROUP BY CATEGORY
ORDER BY TOTALAPP DESC
LIMIT 5;

-- TOP RATED FREE APPS --
SELECT
APP,
CATEGORY,
RATING,REVIEWS
FROM GOOGLEPLAYSTORE
WHERE TYPE ='FREE'
ORDER BY RATING DESC
LIMIT 10;

-- MOST REVIEWD APP --
SELECT
APP,
CATEGORY,
REVIEWS
FROM GOOGLEPLAYSTORE
ORDER BY REVIEWS DESC
LIMIT 10;

-- AVERAGE RATING BY CATEGORY --
SELECT 
    Category,
    AVG(Rating) AS avg_rating
    FROM googleplaystore
WHERE Rating BETWEEN 1 AND 5
GROUP BY Category
ORDER BY avg_rating DESC
LIMIT 5;

-- TOP CATEGORY BY NUMBER OF INSTALLS --
SELECT
CATEGORY,
SUM(CAST(REPLACE(REPLACE(INSTALLS, ',', ''),'+', '')AS UNSIGNED))
AS TOTAL_INSTALLS
FROM GOOGLEPLAYSTORE
GROUP BY CATEGORY
ORDER BY TOTAL_INSTALLS DESC
LIMIT 10;

-- AVERAGE SENTIMENT POLARITY BY CATEGORY --
SELECT 
    g.Category,
    AVG(r.Sentiment_Polarity) AS avg_sentiment
FROM googleplaystore g
JOIN play_store_review1 r
    ON g.App = r.App
WHERE r.Sentiment_Polarity IS NOT NULL
GROUP BY g.Category
ORDER BY avg_sentiment DESC
LIMIT 10;

-- SENTIMENT REVIEWS BY APP CATEGORY --
    SELECT 
	CATEGORY,
	SENTIMENT,
    COUNT(*) AS TOTAL_SENTIMENT
	FROM GOOGLEPLAYSTORE
	JOIN PLAY_STORE_REVIEW1
	ON GOOGLEPLAYSTORE.APP = PLAY_STORE_REVIEW1.APP
    WHERE SENTIMENT <> 'NAN'
    GROUP BY CATEGORY, SENTIMENT
    ORDER BY TOTAL_SENTIMENT DESC
	LIMIT 10;







