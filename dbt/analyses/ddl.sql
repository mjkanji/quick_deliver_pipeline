CREATE TABLE raw_deliveries (
    delivery_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR,
    courier_id VARCHAR,
    requested_timestamp TIMESTAMP,
    delivery_timestamp TIMESTAMP,
    delivery_fee DOUBLE PRECISION,
    status VARCHAR
);

CREATE TABLE raw_couriers (
    courier_id VARCHAR PRIMARY KEY,
    signup_date DATE,
    status VARCHAR,
    vehicle_type VARCHAR
);

CREATE TABLE raw_customers (
    customer_id VARCHAR PRIMARY KEY,
    signup_date DATE,
    primary_payment_method VARCHAR,
    lifetime_value DOUBLE PRECISION
);
