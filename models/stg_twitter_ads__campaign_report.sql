
with base as (

    select * 
    from {{ ref('stg_twitter_ads__campaign_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter_ads__campaign_report_tmp')),
                staging_columns=get_campaign_report_columns()
            )
        }}
    from base
),

final as (
    
    select 
        date as date_day,
        account_id,
        campaign_id,
        clicks,
        impressions,
        billed_charge_local_micro as spend_micro,
        round(billed_charge_local_micro / 1000000.0,2) as spend,
        url_clicks

        {{ fivetran_utils.fill_pass_through_columns('twitter_ads__campaign_report_passthrough_metrics') }}
    
    from fields
)

select *
from final
