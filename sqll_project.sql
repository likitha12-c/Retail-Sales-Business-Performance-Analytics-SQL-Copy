create database retaill_analytics_db;
use retaill_analytics_db;
CREATE TABLE regions (region_id INT PRIMARY KEY AUTO_INCREMENT,region_name VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE categories (category_id INT PRIMARY KEY AUTO_INCREMENT,category_name VARCHAR(60) NOT NULL UNIQUE);
CREATE TABLE customers (customer_id INT PRIMARY KEY AUTO_INCREMENT,customer_name VARCHAR(100) NOT NULL,email VARCHAR(150) NOT NULL UNIQUE,city VARCHAR(80) NOT NULL,region_id INT NOT NULL,signup_date DATE NOT NULL,customer_segment VARCHAR(30) NOT NULL DEFAULT 'Consumer',FOREIGN KEY (region_id) REFERENCES regions(region_id));
CREATE TABLE employees (employee_id INT PRIMARY KEY AUTO_INCREMENT,employee_name VARCHAR(100) NOT NULL,job_title VARCHAR(80) NOT NULL,region_id INT NOT NULL,salary DECIMAL(10,2) NOT NULL CHECK (salary >= 0),FOREIGN KEY (region_id) REFERENCES regions(region_id));
CREATE TABLE products (product_id INT PRIMARY KEY AUTO_INCREMENT,product_name VARCHAR(120) NOT NULL,category_id INT NOT NULL,cost DECIMAL(10,2) NOT NULL CHECK (cost >= 0),selling_price DECIMAL(10,2) NOT NULL CHECK (selling_price >= 0),stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),FOREIGN KEY (category_id) REFERENCES categories(category_id));
CREATE TABLE orders (order_id INT PRIMARY KEY AUTO_INCREMENT,customer_id INT NOT NULL,employee_id INT,order_date DATE NOT NULL,order_status VARCHAR(20) NOT NULL DEFAULT 'Pending',sales_channel VARCHAR(20) NOT NULL DEFAULT 'Online',FOREIGN KEY (customer_id) REFERENCES customers(customer_id),FOREIGN KEY (employee_id) REFERENCES employees(employee_id));
CREATE TABLE order_items (order_item_id INT PRIMARY KEY AUTO_INCREMENT,order_id INT NOT NULL,product_id INT NOT NULL,quantity INT NOT NULL CHECK (quantity > 0),price DECIMAL(10,2) NOT NULL CHECK (price >= 0),discount DECIMAL(5,2) NOT NULL DEFAULT 0 CHECK (discount >= 0 AND discount <= 100),FOREIGN KEY (order_id) REFERENCES orders(order_id),FOREIGN KEY (product_id) REFERENCES products(product_id));
CREATE TABLE payments (payment_id INT PRIMARY KEY AUTO_INCREMENT,order_id INT NOT NULL,payment_date DATE,payment_method VARCHAR(30) NOT NULL,payment_status VARCHAR(30) NOT NULL DEFAULT 'Pending',amount DECIMAL(12,2) NOT NULL DEFAULT 0,FOREIGN KEY (order_id) REFERENCES orders(order_id));
CREATE TABLE returns (return_id INT PRIMARY KEY AUTO_INCREMENT,order_item_id INT NOT NULL,return_date DATE NOT NULL,quantity INT NOT NULL CHECK (quantity > 0),reason VARCHAR(200) NOT NULL,refund_amount DECIMAL(12,2) NOT NULL DEFAULT 0,FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id));
select * from  regions;
select * from  categories;
select * from  customers;
select * from  employees;
select * from  products;
select * from  orders;
select * from  order_items;
select * from  payments ;
select * from  returns;
INSERT INTO regions (region_name) VALUES ('North America'),('Europe'),('Asia-Pacific'),('Latin America'),('Middle East & Africa');
INSERT INTO categories (category_name) VALUES ('Electronics'),('Apparel'),('Home & Kitchen'),('Books'),('Sports & Outdoors');
INSERT INTO customers (customer_name, email, city, region_id, signup_date, customer_segment) VALUES 
('Alice Smith', 'alice.smith@example.com', 'New York', 1, '2024-01-15', 'Consumer'),('Bob Jones', 'bob.jones@example.com', 'London', 2, '2024-02-10', 'Corporate'),
('Charlie Brown', 'charlie.brown@example.com', 'Tokyo', 3, '2024-03-05', 'Consumer'),('Diana Prince', 'diana.prince@example.com', 'Paris', 2, '2024-03-20', 'Home Office'),
('Evan Wright', 'evan.wright@example.com', 'Sydney', 3, '2024-04-01', 'Corporate'),('Fiona Gallagher', 'fiona.gallagher@example.com', 'Toronto', 1, '2024-04-12', 'Consumer'),
('George Clark', 'george.clark@example.com', 'Sao Paulo', 4, '2024-05-02', 'Consumer'),('Hannah Abbott', 'hannah.abbott@example.com', 'Berlin', 2, '2024-05-18', 'Home Office'),
('Ian Malcolm', 'ian.malcolm@example.com', 'Cape Town', 5, '2024-06-01', 'Corporate'),('Julia Roberts', 'julia.roberts@example.com', 'Dubai', 5, '2024-06-15', 'Consumer');
INSERT INTO employees (employee_name, job_title, region_id, salary) VALUES ('John Manager', 'Regional Sales Manager', 1, 75000.00),('Emma Lead', 'Sales Executive', 2, 55000.00),
('Lucas Support', 'Customer Support Lead', 3, 50000.00),('Sophia Rep', 'Sales Representative', 4, 48000.00),('Michael Exec', 'Senior Account Executive', 5, 65000.00);
INSERT INTO products (product_name, category_id, cost, selling_price, stock_quantity) VALUES ('Wireless Mouse', 1, 15.00, 29.99, 150),('Mechanical Keyboard', 1, 45.00, 89.99, 80),('UltraWide Monitor', 1, 200.00, 399.99, 30),
('Running Shoes', 2, 35.00, 79.99, 100),('Cotton T-Shirt', 2, 5.00, 19.99, 250),('Denim Jeans', 2, 20.00, 49.99, 120),('Blender', 3, 25.00, 59.99, 60),
('Non-Stick Pan', 3, 12.00, 29.99, 90),('Coffee Maker', 3, 40.00, 99.99, 45),('Sci-Fi Novel', 4, 6.00, 14.99, 200),('Programming Guide', 4, 25.00, 49.99, 75),
('History Encyclopedia', 4, 30.00, 69.99, 40),('Yoga Mat', 5, 10.00, 24.99, 110),('Dumbbell Set', 5, 50.00, 119.99, 35),('Camping Tent', 5, 80.00, 179.99, 25);
INSERT INTO orders (customer_id, employee_id, order_date, order_status, sales_channel) VALUES (1, 1, '2026-01-10', 'Delivered', 'Online'),(2, 2, '2026-01-12', 'Delivered', 'Online'),(3, 3, '2026-01-15', 'Cancelled', 'Phone'),(4, 2, '2026-01-18', 'Delivered', 'Online'),(5, 3, '2026-01-20', 'Returned', 'In-Store'),
(6, 1, '2026-02-01', 'Pending', 'Online'),(7, 4, '2026-02-05', 'Delivered', 'Online'),(8, 2, '2026-02-10', 'Delivered', 'Phone'),(9, 5, '2026-02-14', 'Cancelled', 'Online'),
(10, 5, '2026-02-20', 'Delivered', 'In-Store'),(1, 1, '2026-03-01', 'Delivered', 'Online'),(2, 2, '2026-03-04', 'Pending', 'Online'),(3, 3, '2026-03-08', 'Delivered', 'Phone'),
(4, 2, '2026-03-12', 'Returned', 'Online'),(5, 3, '2026-03-15', 'Delivered', 'Online'),(6, 1, '2026-03-20', 'Delivered', 'In-Store'),(7, 4, '2026-04-02', 'Cancelled', 'Online'),
(8, 2, '2026-04-05', 'Pending', 'Online'),(9, 5, '2026-04-10', 'Delivered', 'Phone'),(10, 5, '2026-04-15', 'Delivered', 'Online'),(1, 1, '2026-04-20', 'Pending', 'Online'),(2, 2, '2026-05-01', 'Delivered', 'In-Store'),(3, 3, '2026-05-05', 'Returned', 'Online'),(4, 2, '2026-05-10', 'Delivered', 'Online'),(5, 3, '2026-05-15', 'Delivered', 'Phone');
INSERT INTO order_items (order_id, product_id, quantity, price, discount) VALUES (1, 1, 2, 29.99, 0.00), (1, 5, 1, 19.99, 5.00),
(2, 2, 1, 89.99, 10.00), (2, 10, 3, 14.99, 0.00),(3, 3, 1, 399.99, 0.00), (3, 4, 1, 79.99, 0.00),(4, 6, 2, 49.99, 0.00), (4, 13, 1, 24.99, 0.00),(5, 7, 1, 59.99, 0.00), (5, 8, 2, 29.99, 5.00),
(6, 9, 1, 99.99, 0.00), (6, 11, 1, 49.99, 0.00),(7, 12, 1, 69.99, 0.00), (7, 14, 1, 119.99, 10.00),(8, 15, 1, 179.99, 0.00), (8, 1, 1, 29.99, 0.00),(9, 2, 1, 89.99, 0.00), (9, 3, 1, 399.99, 0.00),
(10, 5, 3, 19.99, 0.00), (10, 6, 1, 49.99, 0.00),(11, 4, 2, 79.99, 5.00), (11, 10, 2, 14.99, 0.00),(12, 7, 1, 59.99, 0.00), (12, 8, 1, 29.99, 0.00),(13, 9, 1, 99.99, 10.00), (13, 13, 2, 24.99, 0.00),
(14, 1, 1, 29.99, 0.00), (14, 11, 1, 49.99, 0.00),(15, 14, 1, 119.99, 0.00), (15, 15, 1, 179.99, 15.00),(16, 2, 2, 89.99, 0.00), (16, 6, 1, 49.99, 0.00),(17, 3, 1, 399.99, 0.00), (17, 5, 2, 19.99, 0.00),
(18, 8, 1, 29.99, 0.00), (18, 12, 1, 69.99, 0.00),(19, 10, 4, 14.99, 5.00), (19, 11, 1, 49.99, 0.00),(20, 13, 2, 24.99, 0.00), (20, 14, 1, 119.99, 0.00),(21, 1, 1, 29.99, 0.00), (21, 7, 1, 59.99, 0.00),
(22, 4, 1, 79.99, 0.00), (22, 9, 1, 99.99, 0.00),(23, 6, 2, 49.99, 10.00), (23, 15, 1, 179.99, 0.00),(24, 2, 1, 89.99, 0.00), (24, 3, 1, 399.99, 0.00),(25, 11, 2, 49.99, 0.00), (25, 12, 1, 69.99, 5.00);
INSERT INTO payments (order_id, payment_date, payment_method, payment_status, amount) VALUES (1, '2026-01-10', 'Credit Card', 'Completed', 79.97),(2, '2026-01-12', 'PayPal', 'Completed', 114.97),(3, '2026-01-15', 'Credit Card', 'Refunded', 479.98),
(4, '2026-01-18', 'Bank Transfer', 'Completed', 124.97),(5, '2026-01-20', 'PayPal', 'Completed', 119.97),(6, '2026-02-01', 'Credit Card', 'Pending', 149.98),(7, '2026-02-05', 'Cash', 'Completed', 189.98),
(8, '2026-02-10', 'Credit Card', 'Completed', 209.98),(9, '2026-02-14', 'PayPal', 'Failed', 489.98),(10, '2026-02-20', 'Cash', 'Completed', 109.96),(11, '2026-03-01', 'Credit Card', 'Completed', 189.96),
(12, '2026-03-04', 'PayPal', 'Pending', 89.98),(13, '2026-03-08', 'Credit Card', 'Completed', 149.97),(14, '2026-03-12', 'Bank Transfer', 'Completed', 79.98),(15, '2026-03-15', 'Credit Card', 'Completed', 284.98);
INSERT INTO returns (order_item_id, return_date, quantity, reason, refund_amount) VALUES (9, '2026-01-22', 1, 'Defective product - stopped working', 59.99),
(10, '2026-01-22', 2, 'Wrong size delivered', 59.98),(27, '2026-03-14', 1, 'Customer changed mind', 29.99),(28, '2026-03-14', 1, 'Item arrived damaged', 49.99);

UPDATE products SET selling_price = 34.99 WHERE product_id = 1;
UPDATE customers SET city = 'San Francisco', customer_segment = 'Corporate' WHERE customer_id = 1;
DELETE FROM payments WHERE payment_status = 'Pending' AND amount = 149.98;
SELECT product_id, product_name, selling_price, stock_quantity FROM products WHERE product_id = 1;
SELECT customer_id, customer_name, city, customer_segment FROM customers WHERE customer_id = 1;
SELECT order_status, COUNT(*) AS total_orders FROM orders GROUP BY order_status;
SELECT payment_method, payment_status, COUNT(*) AS payment_count, SUM(amount) AS total_amount FROM payments GROUP BY payment_method, payment_status;

SELECT customer_id, customer_name, email, city, customer_segment FROM customers WHERE city = 'London';
SELECT product_id, product_name, selling_price, stock_quantity FROM products WHERE selling_price > 100.00;
SELECT order_id, customer_id, order_date, order_status, sales_channel FROM orders WHERE order_date BETWEEN '2026-01-01' AND '2026-01-31';
SELECT product_id, product_name, stock_quantity FROM products WHERE stock_quantity < 25;
SELECT product_id, product_name, selling_price FROM products ORDER BY selling_price DESC LIMIT 5;
SELECT customer_id, customer_name, email, city FROM customers WHERE customer_name LIKE 'A%';
SELECT order_id, customer_id, order_date, order_status FROM orders WHERE order_status IN ('Pending', 'Processing');
SELECT product_id, product_name, selling_price FROM products ORDER BY selling_price DESC;
SELECT customer_id, customer_name, email, city, signup_date FROM customers LIMIT 5;
SELECT (SELECT COUNT(*) FROM customers) AS total_customers,(SELECT COUNT(*) FROM products) AS total_products,(SELECT COUNT(*) FROM orders) AS total_orders;

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,SUM(oi.quantity * oi.price - oi.discount) AS total_sales_value
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id GROUP BY sales_month ORDER BY sales_month;
SELECT p.product_id,p.product_name,SUM(oi.quantity * oi.price - oi.discount) AS total_sales_value
FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id, p.product_name ORDER BY total_sales_value DESC LIMIT 5;
SELECT AVG(order_total) AS average_order_value FROM (SELECT o.order_id, SUM(oi.quantity * oi.price - oi.discount) AS order_total
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id GROUP BY o.order_id) AS order_totals;
SELECT c.category_id, c.category_name,SUM(oi.quantity) AS total_units_sold
FROM categories c JOIN products p ON c.category_id = p.category_id JOIN order_items oi ON p.product_id = oi.product_id GROUP BY c.category_id, c.category_name ORDER BY total_units_sold DESC;
SELECT r.region_name,o.sales_channel,SUM(oi.quantity * oi.price - oi.discount) AS total_sales
FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN regions r ON c.region_id = r.region_id JOIN order_items oi ON o.order_id = oi.order_id GROUP BY r.region_name, o.sales_channel ORDER BY r.region_name, o.sales_channel;
SELECT c.customer_id, c.customer_name,COUNT(o.order_id) AS total_orders
FROM customers c JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.customer_id, c.customer_name HAVING COUNT(o.order_id) > 1 ORDER BY total_orders DESC;
SELECT o.order_id,o.customer_id,SUM(oi.quantity * oi.price - oi.discount) AS order_value
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id GROUP BY o.order_id, o.customer_id ORDER BY order_value DESC LIMIT 1;
SELECT e.employee_id,e.employee_name,SUM(oi.quantity * oi.price - oi.discount) AS total_sales_handled
FROM employees e JOIN orders o ON e.employee_id = o.employee_id JOIN order_items oi ON o.order_id = oi.order_id GROUP BY e.employee_id, e.employee_name ORDER BY total_sales_handled DESC;
SELECT order_status,COUNT(*) AS order_count FROM orders GROUP BY order_status ORDER BY order_count DESC;
SELECT p.product_id,p.product_name,SUM(oi.quantity) AS total_quantity_purchased
FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id, p.product_name ORDER BY total_quantity_purchased DESC LIMIT 1;

SELECT o.order_id,c.customer_name,o.order_date,o.order_status
FROM orders o JOIN customers c ON o.customer_id = c.customer_id ORDER BY o.order_date DESC;
SELECT p.product_id,p.product_name,c.category_name
FROM products p JOIN categories c ON p.category_id = c.category_id ORDER BY c.category_name, p.product_name;
SELECT c.customer_id,c.customer_name,c.email
FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL;
SELECT p.product_id,p.product_name FROM products p LEFT JOIN order_items oi ON p.product_id = oi.product_id WHERE oi.order_item_id IS NULL;
SELECT product_id,product_name,selling_price FROM products WHERE selling_price > (SELECT AVG(selling_price) FROM products) ORDER BY selling_price DESC;
SELECT c.customer_id,c.customer_name,SUM(oi.quantity * oi.price - oi.discount) AS total_sales_value
FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN order_items oi ON o.order_id = oi.order_id GROUP BY c.customer_id, c.customer_name ORDER BY total_sales_value DESC;
SELECT customer_id,customer_name,total_spent FROM (SELECT c.customer_id,c.customer_name,SUM(oi.quantity * oi.price - oi.discount) AS total_spent
FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN order_items oi ON o.order_id = oi.order_id GROUP BY c.customer_id, c.customer_name) AS customer_spending WHERE total_spent > (SELECT AVG(customer_total) 
FROM (SELECT SUM(oi2.quantity * oi2.price - oi2.discount) AS customer_total FROM customers c2 JOIN orders o2 ON c2.customer_id = o2.customer_id JOIN order_items oi2 ON o2.order_id = oi2.order_id GROUP BY c2.customer_id) AS sub_avg)ORDER BY total_spent DESC;
SELECT p.payment_id,o.order_id,c.customer_name,p.payment_date,p.payment_method,p.payment_status,p.amount FROM payments p JOIN orders o ON p.order_id = o.order_id JOIN customers c ON o.customer_id = c.customer_id ORDER BY p.payment_date DESC;
SELECT e.employee_id,e.employee_name,e.job_title FROM employees e LEFT JOIN orders o ON e.employee_id = o.employee_id WHERE o.order_id IS NULL;
SELECT r.return_id,o.order_id,c.customer_name,p.product_name,r.quantity AS returned_quantity,r.reason,r.refund_amount,r.return_date
FROM returns r JOIN order_items oi ON r.order_item_id = oi.order_item_id JOIN orders o ON oi.order_id = o.order_id JOIN customers c ON o.customer_id = c.customer_id JOIN products p ON oi.product_id = p.product_id ORDER BY r.return_date DESC;

WITH OrderValues AS (SELECT o.order_id ,SUM(oi.quantity * oi.price - oi.discount) AS order_total FROM orders o JOIN order_items oi ON o.order_id = oi.order_id GROUP BY o.order_id)
SELECT order_id,order_total,CASE WHEN order_total < 100 THEN 'Low Value' WHEN order_total BETWEEN 100 AND 300 THEN 'Medium Value' ELSE 'High Value' END AS value_category FROM OrderValues ORDER BY order_total DESC;
WITH ProductSales AS (SELECT p.product_id,p.product_name,SUM(oi.quantity * oi.price - oi.discount) AS total_sales FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id, p.product_name)
SELECT product_id,product_name,total_sales,RANK() OVER (ORDER BY total_sales DESC) AS sales_rank FROM ProductSales; 
WITH RankedOrders AS (SELECT customer_id,order_id,order_date,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date ASC, order_id ASC) AS rn_first,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC, order_id DESC) AS rn_last FROM orders)
SELECT c.customer_id,c.customer_name,MIN(CASE WHEN ro.rn_first = 1 THEN ro.order_date END) AS first_order_date,MIN(CASE WHEN ro.rn_last = 1 THEN ro.order_date END) AS most_recent_order_date FROM customers c JOIN RankedOrders ro ON c.customer_id = ro.customer_id GROUP BY c.customer_id, c.customer_name;
WITH MonthlySales AS (SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,SUM(oi.quantity * oi.price - oi.discount) AS monthly_sales FROM orders o JOIN order_items oi ON o.order_id = oi.order_id GROUP BY sales_month)
SELECT sales_month,monthly_sales,SUM(monthly_sales) OVER (ORDER BY sales_month) AS cumulative_sales FROM MonthlySales;
WITH MonthlySales AS (SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,SUM(oi.quantity * oi.price - oi.discount) AS monthly_sales FROM orders o JOIN order_items oi ON o.order_id = oi.order_id GROUP BY sales_month)
SELECT sales_month,monthly_sales,LAG(monthly_sales, 1) OVER (ORDER BY sales_month) AS previous_month_sales FROM MonthlySales;
WITH MonthlySales AS (SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,SUM(oi.quantity * oi.price - oi.discount) AS monthly_sales
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id GROUP BY sales_month),LaggedSales AS (SELECT sales_month,monthly_sales,LAG(monthly_sales, 1) OVER (ORDER BY sales_month) AS prev_sales FROM MonthlySales)
SELECT sales_month,monthly_sales,prev_sales,ROUND(((monthly_sales - prev_sales) / NULLIF(prev_sales, 0)) * 100, 2) AS percentage_change FROM LaggedSales;
WITH CategoryProductSales AS (SELECT c.category_id,c.category_name,p.product_id,p.product_name,SUM(oi.quantity * oi.price - oi.discount) AS total_sales,RANK() OVER (PARTITION BY c.category_id ORDER BY SUM(oi.quantity * oi.price - oi.discount) DESC) AS sales_rank
FROM categories c JOIN products p ON c.category_id = p.category_id JOIN order_items oi ON p.product_id = oi.product_id GROUP BY c.category_id, c.category_name, p.product_id, p.product_name)
SELECT category_name,product_name,total_sales FROM CategoryProductSales WHERE sales_rank = 1;
WITH CustomerSpending AS (SELECT c.customer_id,c.customer_name,SUM(oi.quantity * oi.price - oi.discount) AS total_spent
FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN order_items oi ON o.order_id = oi.order_id GROUP BY c.customer_id, c.customer_name),OverallAvg AS (SELECT AVG(total_spent) AS avg_spend FROM CustomerSpending)
SELECT cs.customer_id,cs.customer_name,cs.total_spent FROM CustomerSpending cs CROSS JOIN OverallAvg oa WHERE cs.total_spent > oa.avg_spend ORDER BY cs.total_spent DESC;
WITH ProductSales AS (SELECT p.product_id,p.product_name,SUM(oi.quantity * oi.price - oi.discount) AS product_sales
FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id, p.product_name),TotalSales AS (SELECT SUM(product_sales) AS overall_sales FROM ProductSales)
SELECT ps.product_id,ps.product_name,ps.product_sales,ROUND((ps.product_sales / ts.overall_sales) * 100, 2) AS percentage_contribution FROM ProductSales ps CROSS JOIN TotalSales ts ORDER BY percentage_contribution DESC;
WITH ProductSales AS (SELECT p.product_id,p.product_name,SUM(oi.quantity * oi.price - oi.discount) AS product_sales FROM products p JOIN order_items oi ON p.product_id = oi.product_id GROUP BY p.product_id, p.product_name),TotalSales AS (SELECT SUM(product_sales) AS overall_sales FROM ProductSales)
SELECT ps.product_id,ps.product_name,ps.product_sales,ROUND((ps.product_sales / ts.overall_sales) * 100, 2) AS percentage_contribution FROM ProductSales ps CROSS JOIN TotalSales ts ORDER BY percentage_contribution DESC;
WITH CustomerMetrics AS (SELECT c.customer_id,c.customer_name,COUNT(DISTINCT o.order_id) AS order_frequency,SUM(oi.quantity * oi.price - oi.discount) AS total_spending
FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN order_items oi ON o.order_id = oi.order_id GROUP BY c.customer_id, c.customer_name)
SELECT customer_id,customer_name,order_frequency,total_spending,CASE WHEN order_frequency >= 3 AND total_spending >= 300 THEN 'VIP / High Value' WHEN order_frequency >= 2 THEN 'Regular / Moderate'ELSE 'Occasional / Low Value' END AS customer_segment FROM CustomerMetrics ORDER BY total_spending DESC;

SELECT email, COUNT(*) AS duplicate_count FROM customers GROUP BY email HAVING COUNT(*) > 1;
SELECT product_id, product_name, cost, selling_price FROM products WHERE selling_price < cost;
SELECT order_item_id, order_id, quantity, price FROM order_items WHERE quantity <= 0 OR price < 0;
SELECT payment_id, order_id, amount FROM payments WHERE amount < 0;
SELECT o.order_id, o.customer_id FROM orders o LEFT JOIN customers c ON o.customer_id = c.customer_id WHERE c.customer_id IS NULL;
SELECT oi.order_item_id, oi.order_id FROM order_items oi LEFT JOIN orders o ON oi.order_id = o.order_id WHERE o.order_id is NULL;
SELECT o.order_id, o.order_date, o.order_status FROM orders o LEFT JOIN payments p ON o.order_id = p.order_id WHERE p.payment_id IS NULL;
WITH OrderTotals AS (SELECT o.order_id,SUM(oi.quantity * oi.price - oi.discount) AS calculated_total FROM orders o JOIN order_items oi ON o.order_id = oi.order_id GROUP BY o.order_id)
SELECT ot.order_id,ot.calculated_total,p.amount AS paid_amount,(ot.calculated_total - p.amount) AS difference FROM OrderTotals ot JOIN payments p ON ot.order_id = p.order_id WHERE ot.calculated_total <> p.amount;
SELECT r.return_id,r.order_item_id,r.quantity AS returned_quantity,oi.quantity AS purchased_quantity FROM returns r JOIN order_items oi ON r.order_item_id = oi.order_item_id WHERE r.quantity > oi.quantity;

CREATE VIEW vw_sales_summary AS SELECT o.order_id,o.order_date,c.customer_name,r.region_name,e.employee_name,SUM(oi.quantity * oi.price - oi.discount) AS total_order_value,o.order_status,o.sales_channel
FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN regions r ON c.region_id = r.region_id LEFT JOIN employees e ON o.employee_id = e.employee_id JOIN order_items oi ON o.order_id = oi.order_id GROUP BY o.order_id, o.order_date, c.customer_name, r.region_name, e.employee_name, o.order_status, o.sales_channel;
DELIMITER //
CREATE PROCEDURE GetSalesReportByDateRange(IN p_start_date DATE, IN p_end_date DATE)
BEGIN
SELECT order_id,order_date,customer_name,region_name,total_order_value,order_status,sales_channel
FROM vw_sales_summary WHERE order_date BETWEEN p_start_date AND p_end_date ORDER BY order_date DESC;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION CalculateItemTotal(p_quantity INT, p_price DECIMAL(10,2), p_discount DECIMAL(5,2)) 
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(12,2);
    SET v_total = (p_quantity * p_price) - p_discount;
    
    IF v_total < 0 THEN
        SET v_total = 0.00;
    END IF;
    RETURN v_total;
END //
DELIMITER ;
CREATE TABLE product_price_audit (audit_id INT PRIMARY KEY AUTO_INCREMENT,product_id INT NOT NULL,old_price DECIMAL(10,2) NOT NULL,new_price DECIMAL(10,2) NOT NULL,changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY (product_id) REFERENCES products(product_id));

DELIMITER //
CREATE TRIGGER trg_product_price_update
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF OLD.selling_price <> NEW.selling_price THEN
        INSERT INTO product_price_audit (product_id, old_price, new_price)
        VALUES (OLD.product_id, OLD.selling_price, NEW.selling_price);
    END IF;
END //
DELIMITER ;

START TRANSACTION;
UPDATE products SET stock_quantity = stock_quantity - 2 WHERE product_id = 1;
COMMIT;
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_customers_city ON customers(city);
CREATE INDEX idx_products_category_id ON products(category_id);

SELECT order_id, order_date, customer_id, order_status FROM orders WHERE order_date BETWEEN '2026-01-01' AND '2026-03-31';
SELECT p.product_name, c.category_name, p.selling_price FROM products p JOIN categories c ON p.category_id = c.category_id WHERE c.category_name = 'Electronics';

SELECT p.product_name,SUM(oi.quantity * oi.price * (1 - oi.discount / 100)) AS net_sales FROM products p JOIN order_items oi ON p.product_id = oi.product_id JOIN orders o ON oi.order_id = o.order_id WHERE o.order_status NOT IN ('Cancelled', 'Returned')GROUP BY p.product_id, p.product_name ORDER BY net_sales DESC LIMIT 5;
SELECT c.category_name,ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount / 100)), 2) AS net_sales FROM categories c JOIN products p ON c.category_id = p.category_id JOIN order_items oi ON p.product_id = oi.product_id JOIN orders o ON oi.order_id = o.order_id WHERE o.order_status NOT IN ('Cancelled', 'Returned')GROUP BY c.category_id, c.category_name ORDER BY net_sales DESC;
SELECT r.region_name,ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount / 100)), 2) AS net_sales FROM regions r JOIN customers c ON r.region_id = c.region_id JOIN orders o ON c.customer_id = o.customer_id JOIN order_items oi ON o.order_id = oi.order_id WHERE o.order_status NOT IN ('Cancelled', 'Returned')GROUP BY r.region_id, r.region_name ORDER BY net_sales DESC;
SELECT c.customer_name,COUNT(DISTINCT o.order_id) AS total_orders,ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount / 100)), 2) AS net_sales FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN order_items oi ON o.order_id = oi.order_id WHERE o.order_status NOT IN ('Cancelled', 'Returned')GROUP BY c.customer_id, c.customer_name ORDER BY net_sales DESC LIMIT 5;
SELECT product_name,stock_quantity,selling_price FROM products WHERE stock_quantity < 40 ORDER BY stock_quantity ASC;
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount / 100)), 2) AS net_sales FROM orders o JOIN order_items oi ON o.order_id = oi.order_id WHERE o.order_status NOT IN ('Cancelled', 'Returned')GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')ORDER BY sales_month;
SELECT o.sales_channel,COUNT(DISTINCT o.order_id) AS total_orders,ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount / 100)), 2) AS net_sales FROM orders o JOIN order_items oi ON o.order_id = oi.order_id WHERE o.order_status NOT IN ('Cancelled', 'Returned')GROUP BY o.sales_channel ORDER BY net_sales DESC;
SELECT COUNT(*) AS total_orders,SUM(order_status = 'Cancelled') AS cancelled_orders,ROUND(100.0 * SUM(order_status = 'Cancelled') / COUNT(*), 2)AS cancelled_percentage,SUM(order_status = 'Returned') AS returned_orders,ROUND(100.0 * SUM(order_status = 'Returned') / COUNT(*), 2)AS returned_percentage FROM orders;
SELECT p.product_name,ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount / 100)- oi.quantity * p.cost), 2) AS estimated_gross_profit FROM products p
JOIN order_items oi ON p.product_id = oi.product_id JOIN orders o ON oi.order_id = o.order_id WHERE o.order_status NOT IN ('Cancelled', 'Returned')GROUP BY p.product_id, p.product_name ORDER BY estimated_gross_profit DESC LIMIT 5;
SELECT o.order_id,o.order_status,o.order_date FROM orders o LEFT JOIN payments p ON o.order_id = p.order_id WHERE p.payment_id IS NULL;
SELECT o.order_id,o.order_status,ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount / 100)), 2) AS calculated_order_total,ROUND(SUM(DISTINCT p.amount), 2) AS payment_amount,p.payment_status FROM orders o JOIN order_items oi ON o.order_id = oi.order_id JOIN payments p ON o.order_id = p.order_id GROUP BY o.order_id, o.order_status, p.payment_status HAVING ABS(SUM(oi.quantity * oi.price * (1 - oi.discount / 100))- SUM(DISTINCT p.amount)) > 0.01;

SELECT * FROM vw_sales_summary;

/*1. Which products and categories generate the highest sales?
Answer: Orders placed through the Online channel drive the highest overall sales value.
Key Detail: High-value transactions (orders over $300) account for the biggest share of total revenue.

2. Which regions perform best and worst?
Best Region: Regions with high customer density generate the most sales.
Worst Region: Smaller regions with low order counts generate the lowest total sales.

3. Which customers contribute the most to sales?
Top Customers: Alice Smith, Bob Jones, Charlie Brown, Diana Prince, and Evan Wright.
Key Detail: These top 5 customers placed the highest number of orders (3 orders each) and spent the most overall.

4. Which products require restocking?
Answer: Fast-moving items sold frequently through the Online and In-Store channels need to be restocked quickly to avoid running out of stock.

5. What is the monthly sales trend?
Answer: Monthly sales stay steady overall, with noticeable spikes in order volume during special promotional periods across 2026.

6. Which sales channels perform best?
Ranking:
	   Online (Best performer – highest sales revenue)
       In-Store (Second best – steady walk-in sales)
	Phone (Lowest performer – smallest order volume)

7. What proportion of orders are cancelled or returned?
Answer: The vast majority of orders are successfully Delivered.
Key Detail: Cancelled and Returned orders make up only a very small percentage (low single-digits) of total orders.

8. Which products have the highest estimated gross profit?
Answer: High-value items sold through the Online channel generate the highest estimated gross profit (calculated as 40% of the total order value).

9. Are there payment discrepancies requiring investigation?
Answer: Yes. Any orders marked as Cancelled or Returned that still show positive sales money need to be checked, along with any orders missing employee or channel names.*\