with source as (

    select *
    from {{ ref('stg_twitter_ads__campaign_history_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter_ads__campaign_history_tmp')),
                staging_columns=get_campaign_history_columns()
            )
        }}

    from source

), latest as (

    select
        *,
        round(daily_budget_amount_local_micro / 1000000.0,2) as daily_budget_amount,
        round(total_budget_amount_local_micro / 1000000.0,2) as total_budget_amount,
        row_number() over (partition by campaign_id order by updated_timestamp asc) = 1 as is_latest_version
    from renamed 

)

select * from latest