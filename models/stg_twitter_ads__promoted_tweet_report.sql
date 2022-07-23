with source as (

    select *
    from {{ ref('stg_twitter_ads__promoted_tweet_report_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter_ads__promoted_tweet_report_tmp')),
                staging_columns=get_promoted_tweet_report_columns()
            )
        }}

    from source

), spend_calc as (

    select
        date as date_day,
        account_id,
        promoted_tweet_id,
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(billed_charge_local_micro) as spend_micro,
        round(sum(billed_charge_local_micro) / 1000000.0,2) as spend,
        sum(url_clicks) as url_clicks

        {{ fivetran_utils.fill_pass_through_columns('twitter_ads__promoted_tweet_report_passthrough_metrics') }} -- they have to be aggregated
    
    from renamed
    {{ dbt_utils.group_by(n=3) }}

)

select * from spend_calc