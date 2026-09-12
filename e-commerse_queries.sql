CREATE DATABASE realtime_ecommerce;

USE realtime_ecommerce;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    customer_id INT,
    customer_name VARCHAR(100),
    product_name VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    sales DECIMAL(10,2),
    city VARCHAR(50),
    payment_method VARCHAR(30),
    order_status VARCHAR(30)
);
 show databases;
 USE realtime_ecommerce;
DESCRIBE orders;

USE realtime_ecommerce;

SELECT * 
FROM orders
ORDER BY order_id DESC;

# total sales
SELECT SUM(sales) AS total_sales
FROM orders;

#total orders
SELECT COUNT(*) AS total_orders
FROM orders;

# total customer
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM orders;

# category wise sales
SELECT category,SUM(sales) AS total_sales FROM orders
GROUP BY category
ORDER BY total_sales DESC;

# city wise sales
SELECT city, SUM(sales) AS total_sales  FROM orders
GROUP BY city
ORDER BY total_sales DESC;

# top products
SELECT product_name, SUM(quantity) AS units_sold, SUM(sales) AS total_sales
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

# Order Status Analysis
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

# todays date
SELECT DATE(order_date) AS order_day, SUM(sales) AS total_sales
FROM orders
GROUP BY DATE(order_date)
ORDER BY order_day DESC;

# hour wise sales
SELECT HOUR(order_date) AS order_hour, COUNT(*) AS total_orders, SUM(sales) AS total_sales
FROM orders
GROUP BY HOUR(order_date)
ORDER BY order_hour;

# avg order value
SELECT ROUND(AVG(sales), 2) AS average_order_value
FROM orders;

# city wise
SELECT city, COUNT(*) AS total_orders, SUM(sales) AS total_sales
FROM orders
GROUP BY city
ORDER BY total_sales DESC;

# product wise
SELECT product_name, SUM(quantity) AS units_sold, SUM(sales) AS total_sales
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 1;

# Cancelled Orders
SELECT  COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';

SELECT DISTINCT order_status
FROM orders;

SELECT *
FROM orders
WHERE order_status = 'Cancelled';


SELECT * FROM orders ORDER BY  CASE 
WHEN order_status = 'Cancelled' THEN 1
ELSE 2 END, order_id DESC;

SELECT * FROM orders;

USE realtime_ecommerce;
SELECT *
FROM orders;