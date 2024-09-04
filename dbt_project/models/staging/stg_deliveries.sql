WITH raw_source as (

    select * 
    from {{ source('prod_db', 'raw_deliveries') }}

),

final AS (

    SELECT 
        CAST(delivery_id AS STRING) AS delivery_id,
        CAST(customer_id AS STRING) AS customer_id,
        CAST(courier_id AS STRING) AS courier_id,
        CAST(requested_timestamp AS TIMESTAMP) AS requested_timestamp,
        CAST(delivery_timestamp AS TIMESTAMP) AS delivery_timestamp,
        CAST(delivery_fee AS FLOAT) AS delivery_fee,
        CAST(status AS STRING) AS status
    
    FROM raw_source

)

SELECT * FROM final
