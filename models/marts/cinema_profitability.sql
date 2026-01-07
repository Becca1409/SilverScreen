with movie_costs as (

    select
        movie_id,
        movie_title,
        genre,
        studio,
        month,
        location_id,
        total_invoice_sum as rental_cost
    from {{ ref('int_movie_costs') }}

),

revenue as (

    select
        movie_id,
        month,
        location_id,
        tickets_sold,
        revenue
    from {{ ref('int_revenue') }}

),

final as (

    select
        c.movie_id,
        c.movie_title,
        c.genre,
        c.studio,
        c.month,
        c.location_id as location,
        c.rental_cost,
        r.tickets_sold,
        r.revenue
    from movie_costs c
    left join revenue r
        on c.movie_id = r.movie_id
        and c.location_id = r.location_id
        and c.month = r.month

)

select * from final
