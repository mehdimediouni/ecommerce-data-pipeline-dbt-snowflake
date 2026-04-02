with source as (
    select * from {{ source('olist_raw', 'orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_status,
        cast(order_purchase_timestamp as date) as purchase_at,
        cast(order_approved_at as date) as approved_at,
        cast(order_delivered_carrier_date as date) as delivered_carrier_at,
        cast(order_delivered_customer_date as date) as delivered_customer_at,
        cast(order_estimated_delivery_date as date) as estimated_delivery_at,
        _loaded_at
    from source
)

select * from renamed