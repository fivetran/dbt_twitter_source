{{ config(enabled=var('ad_reporting__twitter_ads_enabled', True)) }}

with source as (

    select *
    from {{ ref('stg_twitter_ads__tweet_url_tmp') }}

),

fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter_ads__tweet_url_tmp')),
                staging_columns=get_tweet_url_columns()
            )
        }}

    from source

), 

final as (

    select
        display_url,
        expanded_url,
        index,
        indices,
        tweet_id,
        url,
        {{ dbt_utils.split_part('expanded_url', "'?'", 1) }} as base_url,
        {{ dbt_utils.get_url_host('expanded_url') }} as url_host,
        '/' || {{ dbt_utils.get_url_path('expanded_url') }} as url_path,
        {{ dbt_utils.get_url_parameter('expanded_url', 'utm_source') }} as utm_source,
        {{ dbt_utils.get_url_parameter('expanded_url', 'utm_medium') }} as utm_medium,
        {{ dbt_utils.get_url_parameter('expanded_url', 'utm_campaign') }} as utm_campaign,
        {{ dbt_utils.get_url_parameter('expanded_url', 'utm_content') }} as utm_content,
        {{ dbt_utils.get_url_parameter('expanded_url', 'utm_term') }} as utm_term
    
    from fields

)

select * from final