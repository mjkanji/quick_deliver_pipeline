with raw_source as (

    select *
    from {{ source('prod_db', 'raw_couriers') }}

),

final as (

    select
        cast(courier_id as string) as courier_id,
        cast(signup_date as date) as signup_date,
        cast(status as string) as status,
        cast(vehicle_type as string) as vehicle_type

    from raw_source

)

select * from final
