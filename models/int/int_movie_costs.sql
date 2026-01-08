with
    invoices_monthly as (

        select
            movie_id, month, location_id, studio, sum(total_invoice_sum) as rental_cost
        from {{ ref("stg_silverscreen__INVOICES") }}
        group by 1, 2, 3, 4

    ),

    movies as (

        select
            movie_id,
            movie_title,
            coalesce(genre, 'unknown') as genre,
            studio as studio_from_catalogue
        from {{ ref("stg_silverscreen__MOVIE_CATALOGUE") }}

    )

select
    i.movie_id,
    i.month,
    i.location_id,
    coalesce(i.studio, m.studio_from_catalogue) as studio,
    i.rental_cost,
    m.movie_title,
    m.genre
from invoices_monthly i
left join movies m on i.movie_id = m.movie_id
