select *
from {{ source('twitter_ads','tweet_url') }}