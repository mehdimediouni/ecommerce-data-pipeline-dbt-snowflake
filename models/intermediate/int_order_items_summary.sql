with order_items as (
    select * from {{ ref('stg_order_items') }}
),

aggregated as (
    select
        order_id,
        sum(price) as total_items_price,
        sum(shipping_cost) as total_shipping_cost,
        sum(total_price) as total_order_amount,
    
        count(product_id) as nb_items,
        count(distinct seller_id) as nb_sellers,
        
        max(_loaded_at) as _loaded_at
    from order_items
    group by 1 
)

select * from aggregated