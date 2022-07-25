{{ config(enabled=var('twitter_ads__using_keywords', true)) }}

select * 
from {{ var('line_item_keywords_report') }}
