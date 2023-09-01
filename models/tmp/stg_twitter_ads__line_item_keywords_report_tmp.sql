ADD source_relation WHERE NEEDED + CHECK JOINS AND WINDOW FUNCTIONS! (Delete this line when done.)

{{ config(enabled=fivetran_utils.enabled_vars(['ad_reporting__twitter_ads_enabled','twitter_ads__using_keywords'])) }}

{{
    fivetran_utils.union_data(
        table_identifier='stg_twitter_ads__line_item_keywords_report', 
        database_variable='twitter_database', 
        schema_variable='twitter_schema', 
        default_database=target.database,
        default_schema='twitter',
        default_variable='stg_twitter_ads__line_item_keywords_report_source',
        union_schema_variable='twitter_union_schemas',
        union_database_variable='twitter_union_databases'
    )
}}