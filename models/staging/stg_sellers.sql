with source as (
    select * from {{ source('olist_raw', 'sellers') }}
),

renamed as (
    select
        seller_id,
        first_name as name,
        family_name as last_name,
        first_name || ' ' || family_name as full_name,
        lower(status) as seniority_level,
        seller_zip_code_prefix as zip_code,
        upper(seller_city) as city,
        upper(seller_state) as state,
        _loaded_at
    from source
)

select * from renamed