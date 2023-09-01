ADD source_relation WHERE NEEDED + CHECK JOINS AND WINDOW FUNCTIONS! (Delete this line when done.)

{{ config(enabled=var('ad_reporting__twitter_ads_enabled', True)) }}

{{
    fivetran_utils.union_data(
        table_identifier='stg_twitter_ads__line_item_history', 
        database_variable='twitter_database', 
        schema_variable='twitter_schema', 
        default_database=target.database,
        default_schema='twitter',
        default_variable='stg_twitter_ads__line_item_history_source',
        union_schema_variable='twitter_union_schemas',
        union_database_variable='twitter_union_databases'
    )
}}