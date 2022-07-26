with source as (

    select *
    from {{ ref('stg_twitter_ads__line_item_history_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_twitter_ads__line_item_history_tmp')),
                staging_columns=get_line_item_history_columns()
            )
        }}

    from source

), latest as (

    select
        *,
        round(bid_amount_local_micro / 1000000.0,2) as bid_amount,
        round(total_budget_amount_local_micro / 1000000.0,2) as total_budget_amount,
        round(target_cpa_local_micro / 1000000.0,2) as target_cpa,
        row_number() over (partition by line_item_id order by updated_timestamp asc) = 1 as is_latest_version
    from renamed 

)

select * from latest