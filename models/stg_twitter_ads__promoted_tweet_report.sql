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
        *,
        -- TOOD: move this over to the passthrough metric framework? 
        round(spend_micro / 1000000.0,2) as spend
    from renamed

)

select * from spend_calc