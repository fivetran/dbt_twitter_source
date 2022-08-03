with source as (

    select *
    from {{ ref('stg_twitter_ads__account_history_tmp') }}

),

fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter_ads__account_history_tmp')),
                staging_columns=get_account_history_columns()
            )
        }}

    from source

), 

final as (

    select
        _fivetran_synced,
        approval_status,
        business_id,
        business_name,
        created_at as created_timestamp,
        deleted as is_deleted,
        id as account_id,
        industry_type,
        name,
        salt,
        timezone,
        timezone_switch_at as timezone_switched_timestamp,
        updated_at as updated_timestamp,
        row_number() over (partition by id order by updated_at asc) = 1 as is_latest_version

    from fields 

)

select * from final