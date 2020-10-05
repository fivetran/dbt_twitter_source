{% macro get_account_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "approval_status", "datatype": dbt_utils.type_string()},
    {"name": "business_id", "datatype": dbt_utils.type_string()},
    {"name": "business_name", "datatype": dbt_utils.type_string()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp(), "alias": "created_timestamp"},
    {"name": "deleted", "datatype": "boolean", "alias": "is_deleted"},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "account_id"},
    {"name": "industry_type", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "salt", "datatype": dbt_utils.type_string()},
    {"name": "timezone", "datatype": dbt_utils.type_string()},
    {"name": "timezone_switch_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp(), "alias": "updated_timestamp"}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_campaign_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp(), "alias": "created_timestamp"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "daily_budget_amount_local_micro", "datatype": dbt_utils.type_int()},
    {"name": "deleted", "datatype": "boolean", "alias": "is_deleted"},
    {"name": "duration_in_days", "datatype": dbt_utils.type_int()},
    {"name": "end_time", "datatype": dbt_utils.type_timestamp(), "alias": "end_timestamp"},
    {"name": "entity_status", "datatype": dbt_utils.type_string()},
    {"name": "frequency_cap", "datatype": dbt_utils.type_int()},
    {"name": "funding_instrument_id", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "campaign_id"},
    {"name": "name", "datatype": dbt_utils.type_string(), "alias": "campaign_name"},
    {"name": "servable", "datatype": "boolean", "alias": "is_servable"},
    {"name": "standard_delivery", "datatype": "boolean"},
    {"name": "start_time", "datatype": dbt_utils.type_timestamp(), "alias": "start_timestamp"},
    {"name": "total_budget_amount_local_micro", "datatype": dbt_utils.type_int()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp(), "alias": "updated_timestamp"}
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
    {"name": "created_at", "datatype": dbt_utils.type_timestamp(), "alias": "created_timestamp"},
    {"name": "creative_source", "datatype": dbt_utils.type_string()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "deleted", "datatype": "boolean", "alias": "is_deleted"},
    {"name": "end_time", "datatype": dbt_utils.type_timestamp(), "alias": "end_timestamp"},
    {"name": "entity_status", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "line_item_id"},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "objective", "datatype": dbt_utils.type_string()},
    {"name": "optimization", "datatype": dbt_utils.type_string()},
    {"name": "primary_web_event_tag", "datatype": dbt_utils.type_string()},
    {"name": "product_type", "datatype": dbt_utils.type_string()},
    {"name": "start_time", "datatype": dbt_utils.type_timestamp(), "alias": "start_timestamp"},
    {"name": "target_cpa_local_micro", "datatype": dbt_utils.type_int()},
    {"name": "total_budget_amount_local_micro", "datatype": dbt_utils.type_int()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp(), "alias": "updated_timestamp"}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_promoted_tweet_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "approval_status", "datatype": dbt_utils.type_string()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp(), "alias": "created_timestamp"},
    {"name": "deleted", "datatype": "boolean", "alias": "is_deleted"},
    {"name": "entity_status", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "promoted_tweet_id"},
    {"name": "line_item_id", "datatype": dbt_utils.type_string()},
    {"name": "tweet_id", "datatype": dbt_utils.type_string()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp(), "alias": "updated_timestamp"}
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

{% macro get_promoted_tweet_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "billed_charge_local_micro", "datatype": dbt_utils.type_int(), "alias": "spend_micro"},
    {"name": "clicks", "datatype": dbt_utils.type_int()},
    {"name": "date", "datatype": dbt_utils.type_timestamp(), "alias": "date_day"},
    {"name": "impressions", "datatype": dbt_utils.type_int()},
    {"name": "promoted_tweet_id", "datatype": dbt_utils.type_string()},
    {"name": "url_clicks", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}