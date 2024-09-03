DROP TABLE IF EXISTS raw_couriers;
DROP TABLE IF EXISTS raw_customers;
DROP TABLE IF EXISTS raw_deliveries;

CREATE TABLE IF NOT EXISTS raw_couriers (
    courier_id VARCHAR, -- PRIMARY KEY,
    signup_date DATE,
    status VARCHAR,
    vehicle_type VARCHAR
);

CREATE TABLE IF NOT EXISTS raw_customers (
    customer_id VARCHAR PRIMARY KEY,
    signup_date DATE,
    primary_payment_method VARCHAR,
    lifetime_value DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS raw_deliveries (
    delivery_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR,
    courier_id VARCHAR,
    requested_timestamp TIMESTAMP,
    delivery_timestamp TIMESTAMP,
    delivery_fee DOUBLE PRECISION,
    status VARCHAR,
    FOREIGN KEY (customer_id) REFERENCES raw_customers(customer_id),
    FOREIGN KEY (courier_id) REFERENCES raw_couriers(courier_id)
);
