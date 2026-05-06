-- =========================================
-- BUSINESS ANALYSIS QUERIES
-- =========================================

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM orders_clean;


-- Orders By Day Of Week
SELECT
    order_dow,
    COUNT(*) AS total_orders
FROM orders_clean
GROUP BY order_dow
ORDER BY order_dow;


-- Peak Ordering Hours
SELECT
    order_hour_of_day,
    COUNT(*) AS total_orders
FROM orders_clean
GROUP BY order_hour_of_day
ORDER BY total_orders DESC;


-- Most Active Users
SELECT
    user_id,
    COUNT(order_id) AS total_orders
FROM orders_clean
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 10;


-- Weekend vs Weekday Orders
SELECT
    is_weekend,
    COUNT(*) AS total_orders
FROM orders_clean
GROUP BY is_weekend;