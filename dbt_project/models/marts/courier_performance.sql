with couriers as (
    select * from {{ ref('couriers_deduped') }}
),

deliveries as (
    select * from {{ ref('stg_deliveries') }}
),

final as (
    select
        couriers.courier_id,

        sum(case when deliveries.status = 'delivered' then 1 else 0 end) as deliveries_completed,
        /*  If fees for only completed deliveries should be included, 
            then we'd need to have a case when statement similar to the one above. */
        avg(deliveries.delivery_fee) as avg_delivery_fee,
        sum(case when deliveries.status = 'delivered' then deliveries.delivery_fee else 0 end) as total_earnings

    
    from couriers
    
    /*  Because some deliveries are missing a `courier_id`, the inner discards those rows, which makes sense,
        since we don't know which courier to attribute those deliveries to. 

        Perhaps we could create a count for 'unknown courier'? */
    inner join deliveries
        on couriers.courier_id = deliveries.courier_id
    group by couriers.courier_id
    /* Maybe we want to filter to just active couriers? */
)

select * from final