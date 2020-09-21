select *
from {{ source('twitter_ads','tweet') }}