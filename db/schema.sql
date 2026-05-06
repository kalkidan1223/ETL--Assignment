CREATE DATABASE ecommerce_db;

-- =========================================
-- E-commerce ETL Project Schema
-- Main Raw Orders Table
-- =========================================

CREATE TABLE IF NOT EXISTS orders (

    order_id INT PRIMARY KEY,

    user_id INT NOT NULL,

    eval_set VARCHAR(20),

    order_number INT,

    order_dow INT,

    order_hour_of_day INT,

    days_since_prior_order FLOAT,

    is_weekend INT

);