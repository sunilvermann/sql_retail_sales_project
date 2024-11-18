# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis
**Database**: `Retail_Sales_Project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Retail_Sales_Project`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales
(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.

  - **Q1. Count how many records in this dataset.**

  ```sql
     SELECT COUNT(*) FROM retail_sales;
  ```

- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

  - **Q2. Find the NULL values in all the columns in dataset.**

  ```sql
     SELECT * FROM retail_sales
  WHERE
     transactions_id IS NULL
  	 OR
  	 sale_date IS NULL
  	 OR
  	 sale_time IS NULL
  	 OR
  	 customer_id IS NULL
  	 OR
  	 gender IS NULL
  	 OR
  	 age IS NULL
  	 OR
  	 category IS NULL
  	 OR
  	 quantity IS NULL
  	 OR
  	 price_per_unit IS NULL
  	 OR
  	 cogs IS NULL
  	 OR
  	 total_sale IS NULL;
  ```

  - **Q3. DELETE the NULL value from the dataset.**

```sql
   DELETE FROM retail_sales
WHERE
   transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

```

- **Customer Count**: Find out how many unique customers are in the dataset.

  - **Q4. How many unique customer we have.**

  ```sql
    SELECT COUNT(DISTINCT customer_id) AS unique_customer FROM retail_sales;
  ```

- **Category Count**: Identify all unique product categories in the dataset.

  - **Q5. How many unique category we have**

  ```sql
    SELECT DISTINCT category FROM retail_sales;
  ```

  - **Q6. How many sales we have?**

  ```sql
    SELECT COUNT(*) AS total_sale FROM retail_sales;
  ```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

**Q7. Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

**Q8. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is >= 4 in the month of Nov-2022**:

```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND quantity >= 4 AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```

**Q9. Write a SQL query to calculate the total sales (total_sale) for each category and count the total orders.**:

```sql
SELECT category, sum(total_sale), COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

**Q10. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

```sql
SELECT  ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category='Beauty';

```

**Q11. Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

**Q12. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

```sql
SELECT category, gender, COUNT(transactions_id) AS total_transaction
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;
```

**Q13. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

```sql
SELECT year, month, average_sale FROM
(SELECT EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
AVG(total_sale) AS average_sale,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM retail_sales
GROUP BY 1,2) AS T1
WHERE rank=1;
```

**Q14. Write a SQL query to find the top 5 customers based on the highest total sales**:

```sql
SELECT customer_id, SUM(total_sale) total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

**Q15. Write a SQL query to find the number of unique customers who purchased items from each category.**:

```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY 1;
```

**Q16. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

```sql
WITH hourly_sale AS
(SELECT *,
     CASE
	 WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	 ELSE 'Evening'
	 END as Shift
FROM retail_sales)
SELECT Shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY Shift;

```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
