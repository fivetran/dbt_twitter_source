{% macro get_line_item_keywords_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "billed_charge_local_micro", "datatype": dbt_utils.type_int()},
    {"name": "clicks", "datatype": dbt_utils.type_int()},
    {"name": "date", "datatype": dbt_utils.type_timestamp()},
    {"name": "impressions", "datatype": dbt_utils.type_int()},
    {"name": "line_item_id", "datatype": dbt_utils.type_string()},
    {"name": "placement", "datatype": dbt_utils.type_string()},
    {"name": "segment", "datatype": dbt_utils.type_string()},
    {"name": "url_clicks", "datatype": dbt_utils.type_int()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('twitter_ads__line_item_keywords_report_passthrough_metrics')) }}

{{ return(columns) }}

{% endmacro %}
