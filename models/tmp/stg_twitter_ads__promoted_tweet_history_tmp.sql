select *
from {{ source('twitter_ads','promoted_tweet_history') }}