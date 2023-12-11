{% macro twitter_ads_extract_url_parameter(field, url_parameter) -%}

{{ adapter.dispatch('twitter_ads_extract_url_parameter', 'twitter_ads_source') (field, url_parameter) }}

{% endmacro %}


{% macro default__twitter_ads_extract_url_parameter(field, url_parameter) -%}

{{ dbt_utils.get_url_parameter(field, url_parameter) }}

{%- endmacro %}


{% macro spark__twitter_ads_extract_url_parameter(field, url_parameter) -%}

{%- set formatted_url_parameter = "'" + url_parameter + "=([^&]+)'" -%}
nullif(regexp_extract({{ field }}, {{ formatted_url_parameter }}, 1), '')

{%- endmacro %}