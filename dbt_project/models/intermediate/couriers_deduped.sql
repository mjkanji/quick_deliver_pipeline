/* Deduplicates the couriers tables by taking the row with the most recent signup_date */

with couriers as (
    select *
    from {{ ref('stg_couriers') }}
),

ordered as (
    select
        *,
        row_number() over (
            partition by courier_id
            order by signup_date desc
        ) as dedup_row
    from couriers
),

final as (
    select
        {{ dbt_utils.star(from=ref('stg_couriers')) }}
    from ordered
    where dedup_row = 1
)


select * from final
