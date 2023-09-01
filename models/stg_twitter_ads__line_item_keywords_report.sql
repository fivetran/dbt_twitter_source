ADD source_relation WHERE NEEDED + CHECK JOINS AND WINDOW FUNCTIONS! (Delete this line when done.)

{{ config(enabled=fivetran_utils.enabled_vars(['ad_reporting__twitter_ads_enabled','twitter_ads__using_keywords'])) }}

with base as (

    select * 
    from {{ ref('stg_twitter_ads__line_item_keywords_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter_ads__line_item_keywords_report_tmp')),
                staging_columns=get_line_item_keywords_report_columns()
            )
        }}
    
        {{ fivetran_utils.source_relation(
            union_schema_variable='twitter_union_schemas', 
            union_database_variable='twitter_union_databases') 
        }}

    from base
),

final as (

    select
        source_relation, 
        {{ dbt.date_trunc('day', 'date') }} as date_day,
        {{ dbt_utils.generate_surrogate_key(['account_id', 'line_item_id','segment','placement']) }} as keyword_id,
        account_id,
        line_item_id,
        segment as keyword,
        placement,
        clicks,
        impressions,
        billed_charge_local_micro as spend_micro,
        round(billed_charge_local_micro / 1000000.0,2) as spend,
        url_clicks

        {{ fivetran_utils.fill_pass_through_columns('twitter_ads__line_item_keywords_report_passthrough_metrics') }}

    from fields
)

select *
from final
