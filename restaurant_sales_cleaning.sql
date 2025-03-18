-- Checking NULL values for each column
SELECT 
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN `Category` IS NULL THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN `Item` IS NULL THEN 1 ELSE 0 END) AS missing_item,
    SUM(CASE WHEN `Price` IS NULL THEN 1 ELSE 0 END) AS missing_price,
    SUM(CASE WHEN `Quantity` IS NULL THEN 1 ELSE 0 END) AS missing_quantity,
    SUM(CASE WHEN `Order Total` IS NULL THEN 1 ELSE 0 END) AS missing_order_total,
    SUM(CASE WHEN `Order Date` IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN `Payment Method` IS NULL THEN 1 ELSE 0 END) AS missing_payment_method
FROM restaurant_sales_data;

-- Updating Item column to frequency of Item
UPDATE restaurant_sales_data AS t1
JOIN (
SELECT Category, `Order Total`, `Item`, COUNT(*) AS freq
FROM restaurant_sales_data
WHERE `Item` IS NOT NULL
GROUP BY Category, `Order Total`, `Item`
ORDER BY Category, freq DESC
) AS t2
ON t1.Category = t2.Category AND t1.`Order Total` = t2.`Order Total`
SET t1.`Item` = t2.`Item`
WHERE t1.`Item` IS NULL;

SELECT *
FROM restaurant_sales_data
WHERE Item IS NULL;

UPDATE restaurant_sales_data
SET Item = 'Unknown'
WHERE Item IS NULL;

-- Checking Payment Method's frequency
SELECT `Payment Method`, COUNT(*) AS freq
FROM restaurant_sales_data
WHERE `Payment Method` IS NOT NULL
GROUP BY `Payment Method`
ORDER BY freq DESC;

-- Updating Payment Method to its frequency
UPDATE restaurant_sales_data AS t1
JOIN (
    SELECT `Payment Method`
    FROM restaurant_sales_data
    WHERE `Payment Method` IS NOT NULL
    GROUP BY `Payment Method`
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS t2
SET t1.`Payment Method` = t2.`Payment Method`
WHERE t1.`Payment Method` IS NULL;

SELECT *
FROM restaurant_sales_data;

SELECT Item, Price
FROM restaurant_sales_data
WHERE Price IS NULL;

SELECT Item, Price
FROM restaurant_sales_data
WHERE Item LIKE 'Side Salad';

-- Updating Price column by item to the known price
UPDATE restaurant_sales_data AS t1
JOIN (
    SELECT Item, Price
    FROM (
        SELECT Item, Price, COUNT(*) AS freq,
               RANK() OVER (PARTITION BY Item ORDER BY COUNT(*) DESC) AS rnk
        FROM restaurant_sales_data
        WHERE Price IS NOT NULL
        GROUP BY Item, Price
    ) AS ranked_prices
    WHERE rnk = 1  -- בוחרים את המחיר עם ההופעה הגבוהה ביותר
) AS t2
ON t1.Item = t2.Item
SET t1.Price = t2.Price
WHERE t1.Price IS NULL;

-- Updating Price where Item is unknown to avg price by category
UPDATE restaurant_sales_data AS t1
JOIN (
SELECT Category ,AVG(Price) as avg_price
FROM restaurant_sales_data
WHERE Price IS NOT NULL
GROUP BY Category) AS t2
ON t1.Category = t2.Category
SET t1.Price = t2.avg_price
WHERE t1.Item = 'Unknown' AND t1.Price IS NULL;

-- Checking the average Quantity for each Item
SELECT Item, ROUND(AVG(Quantity)) as avg_quantity
FROM restaurant_sales_data
WHERE Quantity IS NOT NULL
GROUP BY Item;

-- Updating the NULL values in Quantity to the average Quantity for each Item
UPDATE restaurant_sales_data AS t1
JOIN(
SELECT Item, ROUND(AVG(Quantity)) as avg_quantity
FROM restaurant_sales_data
WHERE Quantity IS NOT NULL
GROUP BY Item) AS t2
ON t1.Item = t2.Item
SET t1.Quantity = t2.avg_quantity
WHERE t1.Quantity IS NULL;

SELECT * 
FROM restaurant_sales_data
WHERE Quantity IS NULL;

SELECT *
FROM restaurant_sales_data
WHERE `Order Total` IS NULL;

-- Updating Order Total by its price*quantity
UPDATE restaurant_sales_data
SET `Order Total` = Price*Quantity
WHERE `Order Total` IS NULL;

-- Checking duplicates by Order ID
SELECT `Order ID`, COUNT(*) AS count_duplicates
FROM restaurant_sales_data
GROUP BY `Order ID`
HAVING count_duplicates > 1;

-- Checking duplicates by Order ID, Item, Price, Quantity, Order Total, Payment Method
SELECT `Order ID`, Item, Price, Quantity, `Order Total`, `Payment Method`, COUNT(*) AS count_duplicates
FROM restaurant_sales_data
GROUP BY `Order ID`, Item, Price, Quantity, `Order Total`, `Payment Method`
HAVING count_duplicates > 1;

-- Orders after cleaning - the same before because there are no duplicates
SELECT COUNT(*) AS total_orders 
FROM restaurant_sales_data;

-- How many customers made orders
SELECT COUNT(DISTINCT `Customer ID`) AS unique_customers 
FROM restaurant_sales_data;

-- Returns the 10 most sold Items
SELECT Item, SUM(Quantity) AS total_sold
FROM restaurant_sales_data
GROUP BY Item
ORDER BY total_sold DESC
LIMIT 10;

-- Returns the 10 most valuable items
SELECT Item, SUM(`Order Total`) AS total_revenue
FROM restaurant_sales_data
GROUP BY Item
ORDER BY total_revenue DESC
LIMIT 10;

-- Income by month and year
SELECT MONTH(`Order Date`) AS month,
	   YEAR(`Order Date`) AS year,
       SUM(`Order Total`) AS total_revenue
FROM restaurant_sales_data
GROUP BY YEAR(`Order Date`), MONTH(`Order Date`)
ORDER BY year, month;

-- Most common payment method
SELECT `Payment Method`, COUNT(*) AS payment_count
FROM restaurant_sales_data
GROUP BY `Payment Method`
ORDER BY payment_count DESC



