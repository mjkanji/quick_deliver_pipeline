WITH raw_source as (

    select * 
    from {{ source('prod_db', 'raw_couriers') }}

),

final AS (

    SELECT 
        CAST(courier_id AS STRING) AS courier_id,
        CAST(signup_date AS DATE) AS signup_date,
        CAST(status AS STRING) AS status,
        CAST(vehicle_type AS STRING) AS vehicle_type
    
    FROM raw_source

)

SELECT * FROM final
