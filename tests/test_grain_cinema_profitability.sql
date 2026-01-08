select movie_id, month, location, count(*) as row_count
from {{ ref("cinema_profitability") }}
group by 1, 2, 3
having count(*) > 1
