{% macro get_account_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "date", "datatype": dbt_utils.type_timestamp()},
    {"name": "engagements", "datatype": dbt_utils.type_int()},
    {"name": "follows", "datatype": dbt_utils.type_int()},
    {"name": "impressions", "datatype": dbt_utils.type_int()},
    {"name": "likes", "datatype": dbt_utils.type_int()},
    {"name": "placement", "datatype": dbt_utils.type_string()},
    {"name": "replies", "datatype": dbt_utils.type_int()},
    {"name": "retweets", "datatype": dbt_utils.type_int()},
    {"name": "unfollows", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
