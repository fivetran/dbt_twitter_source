{{ config(enabled=var('ad_reporting__twitter_ads_enabled', True)) }}

select *
from {{ var('tweet_url') }}