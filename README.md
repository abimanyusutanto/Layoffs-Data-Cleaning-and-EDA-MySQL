# **Layoffs Data Analysis** 

## **Project Overview**

This project focuses on analyzing layoff data from the Layoffs dataset using MySQL. The primary objectives are to clean and preprocess the data to ensure accuracy and consistency, and to perform exploratory data analysis (EDA) to uncover key trends and insights related to company layoffs. Information about the dataset used can be seen [here](https://www.kaggle.com/datasets/swaptr/layoffs-2022).

## **Objectives**

- Ensure the dataset is accurate and consistent by handling missing values, removing duplicates, and standardizing data formats.
- Analyze key patterns and trends in layoffs, including factors such as industry, company size, country, and funding status.
- Perform all data cleaning and EDA exclusively using MySQL queries to demonstrate SQL proficiency.
- Identify meaningful insights about layoffs in 2022, such as industries most affected, trends over time, and regional distributions.
- Structure the cleaned data to be ready for further visualization and reporting if needed.

## **Data Cleaning Process**

1. **Creating a Backup Table**

   ![image](https://github.com/user-attachments/assets/fedfe8f1-f154-4493-9490-78a37662f753)

   First, a duplicate table (layoff_staging) is created from the original layoffs table to ensure that if any mistakes occur during cleaning, we still have the original dataset.
   
2. **Identifying and Removing Duplicate Records**

   ![image](https://github.com/user-attachments/assets/cc188c9d-9612-4cbf-af9e-23cbab0c2de3)

   A Common Table Expression (CTE) (layoff_cte) is used to create a duplicates column, identifying duplicate records based on company, industry, total_laid_off, date, stage, country, and funds_raised_millions.

   ![image](https://github.com/user-attachments/assets/7e030e0c-461f-4046-acf7-d09175842552)

   A new table layoff_staging2 is created with an additional column (duplicates) to store duplicate identification.

   ![image](https://github.com/user-attachments/assets/02c7df63-c08d-488d-8efd-746581f47125)

   The duplicate rows (duplicates > 1) are deleted to remove redundancy.

3. **Standardizing Data**

   ![image](https://github.com/user-attachments/assets/79daefa8-26b1-47a3-8f27-271059efb7b3)
   
   Checking for typos in categorical columns by using SELECT DISTINCT
   
   ![image](https://github.com/user-attachments/assets/5259570e-1d29-4c63-8371-e3c09b4adc91)
   
   ![image](https://github.com/user-attachments/assets/1e495228-4d1d-490e-a066-95e801367def)
   
   Standardizing values in the industry column:
     -  Values like "CryptoCurrency" and "Crypto Currency" are replaced with "Crypto".
     -  "United States." (with a period) is corrected to "United States".

4. **Fixing Date Format**

   ![image](https://github.com/user-attachments/assets/cc1acc1c-8023-485e-87bb-8c354b9f422e)
   
   The date column, initially stored as text, is converted into a proper DATE format using STR_TO_DATE(). The data type of the date column is then modified to DATE for accurate analysis.
   
5. **Handling Missing Values**

     - **Industry Column**
   
       ![image](https://github.com/user-attachments/assets/922f99c5-023d-4c73-87db-0d4ea49ec312)
   
       Identifying rows where industry is NULL or missing.
   
       ![image](https://github.com/user-attachments/assets/43a8231c-6712-4971-9366-9a445c23f2a7)
   
       Changing blank industry values to NULL for easier processing.
   
       ![image](https://github.com/user-attachments/assets/07f5f678-4dcf-4af7-97fa-a1b49970993b)
   
       Filling NULL values by referencing rows with the same company but a valid industry value.
       
     - **Total Laid Off and Percentage Laid Off Columns**
   
       ![image](https://github.com/user-attachments/assets/7bf48482-11ba-4a80-9098-6da35f5cf902)
   
       Checking if both total_laid_off and percentage_laid_off columns are NULL.
   
       ![image](https://github.com/user-attachments/assets/9a8eb974-ddc6-41a6-bb3a-cee953608e5d)
   
       If both are NULL, the rows are deleted, as they provide no meaningful data.

6. **Final Cleanup**

   ![image](https://github.com/user-attachments/assets/4092c716-3182-40d4-bee4-454e2f182919)

   The duplicates column is dropped since it is no longer needed.

   ![image](https://github.com/user-attachments/assets/e1e8011d-2301-48ed-9586-bed87ab4de7d)
   
   The final cleaned dataset is checked using SELECT * FROM layoff_staging2;.

## **Exploratory Data Analysis**

1. **Identifying Companies with the Highest Layoffs**

   ![image](https://github.com/user-attachments/assets/d16c5687-924e-43dc-a5bf-942318e50cb0)

   Companies are ranked by the total number of layoffs, showing the top 5 companies.

   ![image](https://github.com/user-attachments/assets/31b54904-c887-4fc2-9c73-b823039d1db3)

   The top 5 companies with the highest layoffs are Amazon, Google, Meta, Microsoft, and Philips.
   
2. **Identifying Industries with the Highest Layoffs**

   ![image](https://github.com/user-attachments/assets/ea419eb3-c2bd-4530-bb81-f6dae45a5f71)

   Industries are ranked based on the total number of layoffs.

   ![image](https://github.com/user-attachments/assets/c9cde8a1-dcf2-4ed0-a498-6e0bf0a6ff80)

   The top 5 industries most affected are Consumer, Retail, Transportation, Finance, and Other.
   
3. **Identifying Countries with the Highest Layoffs**

   ![image](https://github.com/user-attachments/assets/7bb635a8-f35c-4484-8b85-0317b44504b7)

   Countries are ranked based on the total number of layoffs.

   ![image](https://github.com/user-attachments/assets/d391b711-4ed3-4b56-bd6d-9fcb2afcd5cb)

   The top 5 countries with the highest layoffs are United States, India, Netherlands, Sweden, and Brazil.
   
5. **Layoffs Trends by Year**

   ![image](https://github.com/user-attachments/assets/8713e74b-d588-4e1f-adb9-7f20027d9ee1)

   Layoff trends are analyzed per year to identify spikes and declines.

   ![image](https://github.com/user-attachments/assets/6d823ade-0898-40a5-b7ed-16e24d62509b)

   Layoffs declined in 2021, spiked very high in 2022, and dropped slightly in 2023.

6. **Cumulative (Rolling) Layoff Numbers Over Time**

   ![image](https://github.com/user-attachments/assets/e3c1d6e2-f4b1-4a1d-8d85-dd8be34c7620)

   This query calculates the cumulative number of layoffs from March 2020 to March 2023.

   ![image](https://github.com/user-attachments/assets/9a14fcbd-db7b-4168-8fa4-454d3dcb2d12)
   
7. **Identifying the Top 5 Companies with the Highest Layoffs per Year (2020-2023)**

   ![image](https://github.com/user-attachments/assets/1de41a8e-25d3-4fff-a334-fc6e586bd88e)

   This query ranks the top 5 companies with the most layoffs each year.

   ![image](https://github.com/user-attachments/assets/e694ad8d-d90f-483e-9b73-a74d02b5bbf4)

   This helps track which companies had the most layoffs each year from 2020 to 2023.

## **Conclusion**

This project focused on analyzing global layoff trends using SQL for data cleaning and exploratory data analysis (EDA). The goal was to clean and preprocess the dataset to ensure data accuracy and consistency, followed by an in-depth analysis of layoffs across different industries, companies, and countries. Through this project, we gained valuable insights into how layoffs evolved over time and which sectors were most affected.

In the data cleaning phase, we removed duplicate records, standardized categorical values such as industry and country names, converted date formats for accurate analysis, and handled missing values by filling gaps with relevant data. These steps ensured that our dataset was reliable and ready for further analysis.

During the exploratory data analysis (EDA) phase, we identified Amazon, Google, Meta, Microsoft, and Philips as the companies with the highest layoffs. The Consumer, Retail, Transportation, Finance, and Other sectors were the most impacted industries. Geographically, the United States, India, Netherlands, Sweden, and Brazil experienced the highest layoffs. Our analysis also revealed that layoffs peaked in 2022, surpassing early pandemic levels, and while layoffs declined slightly in 2023, the cumulative job loss remained significantly high.

This project highlights that layoffs were not solely a response to COVID-19, but were also driven by economic downturns, inflation, and corporate restructuring. The increasing number of layoffs in 2022 suggests that companies faced financial challenges beyond pandemic-related disruptions. Although layoffs slowed in 2023, the long-term effects on the global workforce remain substantial.

Overall, this project demonstrates how SQL can be a powerful tool for data cleaning and analysis, enabling businesses, policymakers, and researchers to extract meaningful insights from workforce data. By understanding layoff trends, organizations can make better-informed decisions about labor markets and economic policies.



   






   
