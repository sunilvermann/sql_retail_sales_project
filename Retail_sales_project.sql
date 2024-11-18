--Create Table
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

-- (Alter)change the name of column quantiy to quantity.
ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;

SELECT * FROM retail_sales;

-- Q1. Count how many records in this dataset.
SELECT COUNT(*) FROM retail_sales;

-- Q2. Find the NULL values in all the columns in dataset.
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
	 
-- Q3. DELETE the NULL value from the dataset.	 
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

-- Q4. How many sales we have?
SELECT COUNT(*) AS total_sale FROM retail_sales;

SELECT * FROM retail_sales;
-- Q5. How many unique customer we have?
SELECT COUNT(DISTINCT customer_id) AS unique_customer FROM retail_sales;

-- Q5. How many unique category we have?
SELECT DISTINCT category FROM retail_sales;

-- Q6. Write a SQL query to retrieve all column  for sale made on '2022-11-05' 
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q7. Write a SQL query to retrieve all the transactions where the category is 'Clothing'
-- and the quantity sold is >= 4 in the month of nov-2022? 
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND quantity >= 4 AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

-- Q8. Write a SQL query to calculate the total sales(total_sale) for each category
-- and count the total orders.
SELECT category, sum(total_sale), COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Q9. Write a SQL query to find the average age of customer 
-- who purchased items from the 'Beauty' category. 
SELECT  ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category='Beauty';

-- Q10. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q11. Write a SQL query to find the total number of transactions(transactions_id) 
-- made by each gender in each category. 
SELECT category, gender, COUNT(transactions_id) AS total_transaction
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;

-- Q12. Write a SQL query to calculate the average sale for each month.
-- find the best selling month each year.
SELECT year, month, average_sale FROM 
(SELECT EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
AVG(total_sale) AS average_sale,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank 
FROM retail_sales
GROUP BY 1,2) AS T1
WHERE rank=1;

-- Q13. Write a SQL query to find the top 5 customers based on the highest total sale.
SELECT customer_id, SUM(total_sale) total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- Q14. Write SQL query to find the number of unique customers
-- who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers 
FROM retail_sales
GROUP BY 1;

-- Q15. Write a SQL query to create each shift and number of orders (Example Morning <12,
-- Afternoon between 12 & 17, Evening > 17).
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
