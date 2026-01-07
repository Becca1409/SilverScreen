with 

source as (

    select * from {{ source('silverscreen', 'MOVIE_CATALOGUE') }}

),

renamed as (

    select
        movie_id,
        movie_title,
        release_date,
        COALESCE(genre, 'unknown') AS genre,
        country,
        studio,
        budget,
        director,
        rating,
        minutes

    from source

)

select * from renamed