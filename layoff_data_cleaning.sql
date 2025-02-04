-- Data Cleaning Project

SELECT *
FROM layoffs;

CREATE TABLE layoff_staging
LIKE layoffs;

INSERT layoff_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoff_staging;

# The purpose of creating an identical table is so that if we make a mistake, we still have a backup of the original dataset.

WITH layoff_cte AS
(
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, 'date', stage, country, funds_raised_millions) AS duplicates		
	FROM layoff_staging
)
SELECT *
FROM layoff_cte
WHERE duplicates > 1;

# Making a new column that shows data duplicates

DROP TABLE IF EXISTS `layoff_staging2`;
CREATE TABLE `layoff_staging2` (
  `company` text DEFAULT NULL,
  `location` text DEFAULT NULL,
  `industry` text DEFAULT NULL,
  `total_laid_off` int(11) DEFAULT NULL,
  `percentage_laid_off` text DEFAULT NULL,
  `date` text DEFAULT NULL,
  `stage` text DEFAULT NULL,
  `country` text DEFAULT NULL,
  `funds_raised_millions` int(11) DEFAULT NULL,
  `duplicates` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO layoff_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, 'date', stage, country, funds_raised_millions) AS duplicates
FROM layoff_staging;

# Again the purpose of creating an identical table is so that if we make a mistake, we still have a backup of the original dataset.

DELETE
FROM layoff_staging2
WHERE duplicates > 1;

# Deleting data duplicates

SELECT * 
FROM layoff_staging2
WHERE duplicates > 1;

-- Standardizing Data

SELECT DISTINCT industry
FROM layoff_staging2
ORDER BY 1;

# Checking if there are some typo in the industry column

UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

# Changing CryptoCurrency and Crypto Currency into Crypto because they are the same

SELECT DISTINCT industry
FROM layoff_staging2
ORDER BY 1;

SELECT DISTINCT country
FROM layoff_staging2
ORDER BY 1;

# Checking if there are some typo in the country column

UPDATE layoff_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

# Changing United States. (has dot at the end of the word) into United States

SELECT DISTINCT country
FROM layoff_staging2
ORDER BY 1;

SELECT `date`
FROM layoff_staging2;

UPDATE layoff_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;

# Changing `date` data type from text to datetime

-- Populize NULL or Missing Data

SELECT *
FROM layoff_staging2
WHERE industry IS NULL OR industry = '';

# Checking null and missing values in industry column

UPDATE layoff_staging2
SET industry = NULL
WHERE industry = '';

# Changing the missing values into null so we can fill it later easily

SELECT t1.company, t1.industry, t2.industry
FROM layoff_staging2 t1
JOIN layoff_staging2 t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

# This query helps to find rows where industry is null and there are other rows with the same company that have valid industry values.

UPDATE layoff_staging2 t1
JOIN layoff_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

# Changing the rows where industry is null to the same company that have valid industry values.

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

# Checking total_laid_off and percentage_laid_off column who has null

DELETE
FROM layoff_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

# Deleting total_laid_off and percentage_laid_off column who has null because the data is useless

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

ALTER TABLE layoff_staging2
DROP COLUMN duplicates;

# Dropping duplicates because we dont need it anymore

SELECT *
FROM layoff_staging2;


















