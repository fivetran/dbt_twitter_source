{% macro get_account_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "approval_status", "datatype": dbt_utils.type_string()},
    {"name": "business_id", "datatype": dbt_utils.type_string()},
    {"name": "business_name", "datatype": dbt_utils.type_string()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "deleted", "datatype": "boolean"},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "industry_type", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "salt", "datatype": dbt_utils.type_string()},
    {"name": "timezone", "datatype": dbt_utils.type_string()},
    {"name": "timezone_switch_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_campaign_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "daily_budget_amount_local_micro", "datatype": dbt_utils.type_int()},
    {"name": "deleted", "datatype": "boolean"},
    {"name": "duration_in_days", "datatype": dbt_utils.type_int()},
    {"name": "end_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "entity_status", "datatype": dbt_utils.type_string()},
    {"name": "frequency_cap", "datatype": dbt_utils.type_int()},
    {"name": "funding_instrument_id", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "servable", "datatype": "boolean"},
    {"name": "standard_delivery", "datatype": "boolean"},
    {"name": "start_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "total_budget_amount_local_micro", "datatype": dbt_utils.type_int()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_line_item_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "advertiser_domain", "datatype": dbt_utils.type_string()},
    {"name": "advertiser_user_id", "datatype": dbt_utils.type_int()},
    {"name": "automatically_select_bid", "datatype": "boolean"},
    {"name": "bid_amount_local_micro", "datatype": dbt_utils.type_int()},
    {"name": "bid_type", "datatype": dbt_utils.type_string()},
    {"name": "bid_unit", "datatype": dbt_utils.type_string()},
    {"name": "campaign_id", "datatype": dbt_utils.type_string()},
    {"name": "charge_by", "datatype": dbt_utils.type_string()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "creative_source", "datatype": dbt_utils.type_string()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "deleted", "datatype": "boolean"},
    {"name": "end_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "entity_status", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "objective", "datatype": dbt_utils.type_string()},
    {"name": "optimization", "datatype": dbt_utils.type_string()},
    {"name": "primary_web_event_tag", "datatype": dbt_utils.type_string()},
    {"name": "product_type", "datatype": dbt_utils.type_string()},
    {"name": "start_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "target_cpa_local_micro", "datatype": dbt_utils.type_int()},
    {"name": "total_budget_amount_local_micro", "datatype": dbt_utils.type_int()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_promoted_tweet_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "approval_status", "datatype": dbt_utils.type_string()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "deleted", "datatype": "boolean"},
    {"name": "entity_status", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "line_item_id", "datatype": dbt_utils.type_string()},
    {"name": "tweet_id", "datatype": dbt_utils.type_string()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_scheduled_promoted_tweet_history_columns() %}

{% set columns = [
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_media_creative_history_columns() %}

{% set columns = [
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_tweet_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "card_uri", "datatype": dbt_utils.type_string()},
    {"name": "coordinates_coordinates", "datatype": dbt_utils.type_string()},
    {"name": "coordinates_type", "datatype": dbt_utils.type_string()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "favorite_count", "datatype": dbt_utils.type_int()},
    {"name": "favorited", "datatype": "boolean"},
    {"name": "followers", "datatype": "boolean"},
    {"name": "full_text", "datatype": dbt_utils.type_string()},
    {"name": "geo_coordinates", "datatype": dbt_utils.type_string()},
    {"name": "geo_type", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "in_reply_to_screen_name", "datatype": dbt_utils.type_string()},
    {"name": "in_reply_to_status_id", "datatype": dbt_utils.type_string()},
    {"name": "in_reply_to_user_id", "datatype": dbt_utils.type_string()},
    {"name": "lang", "datatype": dbt_utils.type_string()},
    {"name": "media_key", "datatype": dbt_utils.type_string()},
    {"name": "retweet_count", "datatype": dbt_utils.type_int()},
    {"name": "retweeted", "datatype": "boolean"},
    {"name": "source", "datatype": dbt_utils.type_string()},
    {"name": "truncated", "datatype": "boolean"},
    {"name": "tweet_type", "datatype": dbt_utils.type_string()},
    {"name": "user_id", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_tweet_url_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "display_url", "datatype": dbt_utils.type_string()},
    {"name": "expanded_url", "datatype": dbt_utils.type_string()},
    {"name": "index", "datatype": dbt_utils.type_int()},
    {"name": "indices", "datatype": dbt_utils.type_string()},
    {"name": "tweet_id", "datatype": dbt_utils.type_string()},
    {"name": "url", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_tweet_media_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "display_url", "datatype": dbt_utils.type_string()},
    {"name": "expanded_url", "datatype": dbt_utils.type_string()},
    {"name": "indices", "datatype": dbt_utils.type_string()},
    {"name": "media_id", "datatype": dbt_utils.type_string()},
    {"name": "media_url", "datatype": dbt_utils.type_string()},
    {"name": "media_url_https", "datatype": dbt_utils.type_string()},
    {"name": "sizes", "datatype": dbt_utils.type_string()},
    {"name": "tweet_id", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "url", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}