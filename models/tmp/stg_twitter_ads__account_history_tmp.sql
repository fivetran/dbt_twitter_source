select *
from {{ source('twitter_ads','account_history') }}