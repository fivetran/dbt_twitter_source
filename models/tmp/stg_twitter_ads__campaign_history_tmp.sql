select *
from {{ source('twitter_ads','campaign_history') }}