select
    i.movie_id,
    month,
    location_id,
    i.studio,
    total_invoice_sum,
    movie_title,
    coalesce(genre, 'unknown') as genre
from {{ ref("stg_silverscreen__INVOICES") }} as i
left join {{ ref("stg_silverscreen__MOVIE_CATALOGUE") }} as m on i.movie_id = m.movie_id
