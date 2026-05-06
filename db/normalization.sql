-- =========================================
-- Normalized Database Design
-- =========================================

-- USERS TABLE
CREATE TABLE IF NOT EXISTS users (

    user_id INT PRIMARY KEY

);

-- CLEAN ORDERS TABLE
CREATE TABLE IF NOT EXISTS orders_clean (

    order_id INT PRIMARY KEY,

    user_id INT,

    eval_set VARCHAR(20),

    order_number INT,

    order_dow INT,

    order_hour_of_day INT,

    days_since_prior_order FLOAT,

    is_weekend INT,

    CONSTRAINT fk_user
        FOREIGN KEY(user_id)
            REFERENCES users(user_id)

);

-- =========================================
-- INSERT UNIQUE USERS
-- =========================================

INSERT INTO users (user_id)

SELECT DISTINCT user_id
FROM orders
ON CONFLICT (user_id) DO NOTHING;

-- =========================================
-- INSERT CLEANED ORDERS
-- =========================================

INSERT INTO orders_clean (

    order_id,
    user_id,
    eval_set,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order,
    is_weekend

)

SELECT
    order_id,
    user_id,
    eval_set,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order,
    is_weekend

FROM orders

ON CONFLICT (order_id) DO NOTHING;