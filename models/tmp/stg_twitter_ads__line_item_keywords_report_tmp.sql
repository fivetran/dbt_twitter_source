{{ config(enabled=fivetran_utils.enabled_vars(['ad_reporting__twitter_ads_enabled','twitter_ads__using_keywords'])) }}

select * 
from {{ var('line_item_keywords_report') }}
