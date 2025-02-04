-- Exploratory Data Analysis

SELECT *
FROM layoff_staging2 AS ls2;
    
SELECT company, SUM(total_laid_off) total_laid_off
FROM layoff_staging2 AS ls2
WHERE total_laid_off IS NOT NULL
GROUP BY company
ORDER BY total_laid_off DESC
LIMIT 5;
    
# Amazon, Google, Meta, MIcrosoft, dan Philips have the highest number of employees laid off
    
SELECT industry, SUM(total_laid_off) total_laid_off
FROM layoff_staging2 AS ls2
WHERE total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY total_laid_off DESC
LIMIT 5;
    
# Layoffs were carried out in many sectors. The highest are from Consumer, Retail, Transportation, Finance, and Other industry sectors.
    
SELECT country, SUM(total_laid_off) total_laid_off
FROM layoff_staging2 AS ls2
WHERE total_laid_off IS NOT NULL
GROUP BY country
ORDER BY total_laid_off DESC
LIMIT 5;
    
# Many countries are doing layoffs. Five of the highest are United States, India, Netherlands, Sweden, and Brazil
    
SELECT YEAR(`date`) `year`, SUM(total_laid_off) total_laid_off
FROM world_layoffs.layoff_staging2 AS ls2
WHERE total_laid_off IS NOT NULL
AND YEAR(`date`) IS NOT NULL
GROUP BY `year`
ORDER BY 1 
LIMIT 5;
    
# Layoffs decline in 2021 but spike very high in 2022 and drop slightly in 2023
    
SELECT SUBSTRING(`date`,1,7) AS `year_month`, SUM(total_laid_off) laid_off
FROM layoff_staging2 AS ls2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `year_month`
ORDER BY 1 ASC;
    
WITH rolling_number_cte AS
(
	SELECT SUBSTRING(`date`,1,7) AS `year_month`, SUM(total_laid_off) AS laid_off
	FROM layoff_staging2 AS ls2
	WHERE SUBSTRING(`date`,1,7) IS NOT NULL
	GROUP BY `year_month`
	ORDER BY 1 ASC
)
SELECT `year_month`, laid_off,
SUM(laid_off) OVER(ORDER BY `year_month`) AS rolling_number
FROM rolling_number_cte;

# Query above shows rolling number of layoffs from year 2020 month 3 to year 2023 month 3. 

WITH company_laid_off (company, years, total_laid_off) AS
(    
	SELECT company, YEAR(`date`), SUM(total_laid_off) total_laid_off
	FROM world_layoffs.layoff_staging2 AS ls2
	WHERE total_laid_off IS NOT NULL
	GROUP BY company
	ORDER BY total_laid_off DESC   
),
company_laid_off_ranking AS
(
SELECT company, years, total_laid_off,
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_laid_off
WHERE years IS NOT NULL
)
SELECT *
FROM company_laid_off_ranking
WHERE Ranking <= 5;

# Showing the top 5 company with the most layoff from 2020-2023
    
    
    
    
    
    
    
    
    
