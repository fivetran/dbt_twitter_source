select *
from {{ source('twitter_ads','line_item_history') }}