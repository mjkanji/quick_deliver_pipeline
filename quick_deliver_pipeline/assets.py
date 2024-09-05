from textwrap import dedent

import duckdb
from dagster import AssetExecutionContext, asset

from .project import DBT_PROJECT_PATH


@asset(key_prefix=["duckdb", "prod_db"])
def raw_customers(context: AssetExecutionContext):
    with duckdb.connect(DBT_PROJECT_PATH.joinpath("mydb.ddb").as_posix()) as con:
        con.execute("TRUNCATE raw_customers;")
        con.execute(
            dedent("""
                INSERT INTO raw_customers (customer_id, signup_date, primary_payment_method, lifetime_value) VALUES
                ('cust_001', '2022-01-15', 'credit_card', 250.00),
                ('cust_002', '2022-03-22', 'paypal', 150.50),
                ('cust_003', '2022-05-30', 'apple_pay', 300.75),
                ('cust_004', '2022-07-01', 'credit_card', 425.20),
                ('cust_005', '2022-08-10', 'paypal', 180.00);
            """)
        )


@asset(key_prefix=["duckdb", "prod_db"])
def raw_couriers(context: AssetExecutionContext, raw_customers):
    with duckdb.connect(DBT_PROJECT_PATH.joinpath("mydb.ddb").as_posix()) as con:
        con.execute("TRUNCATE raw_couriers;")
        con.execute(
            dedent("""
                INSERT INTO raw_couriers (courier_id, signup_date, status, vehicle_type) VALUES
                ('cour_001', '2022-01-10', 'inactive', 'car'),
                ('cour_002', '2022-02-25', 'active', 'car'),
                ('cour_003', '2022-04-05', 'inactive', 'scooter'),
                ('cour_004', '2022-06-15', 'active', 'van'),
                ('cour_001', '2022-09-20', 'active', 'bike');
            """)
        )


@asset(key_prefix=["duckdb", "prod_db"])
def raw_deliveries(context: AssetExecutionContext, raw_couriers):
    with duckdb.connect(DBT_PROJECT_PATH.joinpath("mydb.ddb").as_posix()) as con:
        con.execute("TRUNCATE raw_deliveries;")
        con.execute(
            dedent("""
                INSERT INTO raw_deliveries (delivery_id, customer_id, courier_id, requested_timestamp, delivery_timestamp, delivery_fee, status) VALUES
                ('deliv_001', 'cust_001', 'cour_001', '2023-01-01 10:00:00', '2023-01-01 10:30:00', 5.99, 'delivered'),
                ('deliv_002', 'cust_002', 'cour_002', '2023-01-15 14:00:00', '2023-01-15 14:45:00', 7.50, 'delivered'),
                ('deliv_003', 'cust_003', NULL, '2023-02-01 09:00:00', '2023-02-01 09:25:00', 6.75, 'delivered'),
                ('deliv_004', 'cust_004', 'cour_004', '2023-02-10 11:30:00', '2023-02-10 12:10:00', 8.99, 'canceled'),
                ('deliv_005', 'cust_005', 'cour_001', '2023-03-05 13:45:00', '2023-03-05 14:20:00', 4.50, 'delivered');
            """)
        )


assets = []
