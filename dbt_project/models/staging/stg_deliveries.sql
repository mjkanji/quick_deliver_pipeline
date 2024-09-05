with raw_source as (

    select *
    from {{ source('prod_db', 'raw_deliveries') }}

),

final as (

    select
        cast(delivery_id as string) as delivery_id,
        cast(customer_id as string) as customer_id,
        cast(courier_id as string) as courier_id,
        cast(requested_timestamp as timestamp) as requested_timestamp,
        cast(delivery_timestamp as timestamp) as delivery_timestamp,
        cast(delivery_fee as float) as delivery_fee,
        cast(status as string) as status

    from raw_source

)

select * from final
