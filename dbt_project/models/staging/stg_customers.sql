with raw_source as (

    select *
    from {{ source('prod_db', 'raw_customers') }}

),

final as (

    select
        cast(customer_id as string) as customer_id,
        cast(signup_date as date) as signup_date,
        cast(primary_payment_method as string) as primary_payment_method,
        cast(lifetime_value as float) as lifetime_value

    from raw_source

)

select * from final
