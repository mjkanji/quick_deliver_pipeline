WITH raw_source as (

    select *
    from {{ source('prod_db', 'raw_customers') }}

),

final AS (

    SELECT 
        CAST(customer_id AS STRING) AS customer_id,
        CAST(signup_date AS DATE) AS signup_date,
        CAST(primary_payment_method AS STRING) AS primary_payment_method,
        CAST(lifetime_value AS FLOAT) AS lifetime_value
    
    FROM raw_source

)

SELECT * FROM final
