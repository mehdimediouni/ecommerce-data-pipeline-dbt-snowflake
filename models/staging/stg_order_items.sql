with source as (
    select * from {{ source('olist_raw', 'order_items') }}
),

renamed as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        cast(shipping_limit_date as date) as shipping_limit_at,
        cast(price as float) as price,
        cast(freight_value as float) as shipping_cost,
        _loaded_at
    from source
)

select * from renamed