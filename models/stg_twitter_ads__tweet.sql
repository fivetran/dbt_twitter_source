
with base as (

    select * 
    from {{ ref('stg_twitter_ads__tweet_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter_ads__tweet_tmp')),
                staging_columns=get_tweet_columns()
            )
        }}
    from base
),

final as (
    
    select 
        account_id,
        id as tweet_id,
        name,
        full_text,
        lang as language

    from fields
)

select *
from final
