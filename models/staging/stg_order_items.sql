with source as (
    select * from {{ source('olist_raw', 'order_items') }}
),

renamed as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date::date as shipping_limit_date,
        price::number(10, 2) as price,
        freight_value::number(10, 2) as shipping_cost,
        _loaded_at
    from source
),

enriched as (
    select
        * exclude (_loaded_at),
        (price + shipping_cost) as total_price,
        case 
            when max(order_item_id) over (partition by order_id) > 1 then true 
            else false 
        end as is_multi_item_order,
        datediff('day', current_date(), shipping_limit_date) as days_before_shipping_limit,
        round(
            (shipping_cost / nullif(price + shipping_cost, 0)) * 100, 
            2
        ) as shipping_cost_ratio,
            _loaded_at
    from renamed
)

select * from enriched