with source as (

    select *
    from {{ ref('stg_twitter_ads__campaign_history_tmp') }}

),

renamed as (

    select
    
        {{
            fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter_ads__campaign_history_tmp')),
                staging_columns=get_campaign_history_columns()
            )
        }}

    from source

)

select * from renamed