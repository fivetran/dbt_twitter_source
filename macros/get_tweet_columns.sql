{% macro get_tweet_columns() %}

{% set columns = [
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "full_text", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "lang", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
] %}

{{ return(columns) }}

{% endmacro %}
