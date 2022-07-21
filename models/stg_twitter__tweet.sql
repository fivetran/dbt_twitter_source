
with base as (

    select * 
    from {{ ref('stg_twitter__tweet_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter__tweet_tmp')),
                staging_columns=get_tweet_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        account_id,
        card_uri,
        coordinates_coordinates,
        coordinates_type,
        created_at,
        favorite_count,
        favorited,
        followers,
        full_text,
        geo_coordinates,
        geo_type,
        id,
        in_reply_to_screen_name,
        in_reply_to_status_id,
        in_reply_to_user_id,
        lang,
        media_key,
        name,
        retweet_count,
        retweeted,
        source,
        truncated,
        tweet_type,
        user_id
    from fields
)

select *
from final
