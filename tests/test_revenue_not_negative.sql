select *
from {{ ref('cinema_profitability') }}
where revenue < 0