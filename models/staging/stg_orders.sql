with source as (
    select * from {{ source('olist_raw', 'orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        upper(order_status) as order_status,
        cast(order_purchase_timestamp as date) as purchase_date,
        cast(order_approved_at as date) as approved_date,
        cast(order_delivered_carrier_date as date) as delivered_carrier_date,
        cast(order_delivered_customer_date as date) as delivered_customer_date,
        cast(order_estimated_delivery_date as date) as estimated_delivery_date,
        _loaded_at
    from source
),

enriched as (
    select
        * exclude (_loaded_at),

        -- Approbation performance
        datediff('day', purchase_date, approved_date) as days_to_approve,

        -- Logistics performance (actual vs estimated)
        datediff('day', purchase_date, delivered_customer_date) as actual_delivery_duration,
        datediff('day', purchase_date, estimated_delivery_date) as estimated_delivery_duration,
        datediff('day', estimated_delivery_date, delivered_customer_date) as delivery_delay,

        -- late delivery flags
        case 
            when delivered_customer_date > estimated_delivery_date then true 
            else false 
        end as is_late_delivery,

        _loaded_at
    from renamed
)

select * from enriched