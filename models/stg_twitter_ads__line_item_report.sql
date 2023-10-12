{{ config(enabled=var('ad_reporting__twitter_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_twitter_ads__line_item_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter_ads__line_item_report_tmp')),
                staging_columns=get_line_item_report_columns()
            )
        }}
    
        {{ fivetran_utils.source_relation(
            union_schema_variable='twitter_ads_union_schemas', 
            union_database_variable='twitter_ads_union_databases') 
        }}

    from base
),

final as (

    select
        source_relation, 
        {{ dbt.date_trunc('day', 'date') }} as date_day,
        account_id,
        line_item_id,
        placement,
        clicks,
        impressions,
        billed_charge_local_micro as spend_micro,
        round(billed_charge_local_micro / 1000000.0,2) as spend,
        url_clicks

        {{ fivetran_utils.fill_pass_through_columns('twitter_ads__line_item_report_passthrough_metrics') }}

    from fields
)

select *
from final
