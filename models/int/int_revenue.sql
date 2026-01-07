with nj_001 as (

    select
        movie_id,
        transaction_month as month,
        location_id,
        sum(ticket_amount) as tickets_sold,
        sum(revenue) as revenue
    from {{ ref('stg_silverscreen__NJ_001') }}
    group by 1, 2, 3

),

nj_002 as (

    select
        movie_id,
        transaction_month as month,
        location_id,
        sum(ticket_amount) as tickets_sold,
        sum(revenue) as revenue
    from {{ ref('stg_silverscreen__NJ_002') }}
    group by 1, 2, 3

),

nj_003 as (

    select
        movie_id,
        transaction_month as month,
        location_id,
        sum(ticket_amount) as tickets_sold,
        sum(revenue) as revenue
    from {{ ref('stg_silverscreen__NJ_003') }}
    group by 1, 2, 3

),

unioned as (

    select * from nj_001
    union all
    select * from nj_002
    union all
    select * from nj_003

),

final as (

    select
        movie_id,
        month,
        location_id,
        sum(tickets_sold) as tickets_sold,
        sum(revenue) as revenue
    from unioned
    group by 1, 2, 3

)

select * from final
