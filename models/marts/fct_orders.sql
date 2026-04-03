with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('int_order_items_summary') }}
),

payments as (
    select * from {{ ref('int_payments_summary') }}
),

final as (
    select
        -- Identifiants
        o.order_id,
        o.customer_id,
        o.order_status,
        
        -- Dates (déjà castées en DATE dans ton staging)
        o.purchase_date,
        o.approved_date,
        o.delivered_customer_date,
        o.estimated_delivery_date,

        -- Performance Logistique (importées de ton staging)
        o.days_to_approve,
        o.actual_delivery_duration,
        o.delivery_delay,
        o.is_late_delivery,

        -- Finances & Articles (depuis intermediate items)
        i.total_items_price,
        i.total_shipping_cost,
        i.total_order_amount,
        i.nb_items,
        
        -- Paiements (depuis intermediate payments)
        p.total_payment_amount, 
        p.nb_installments,
        p.nb_payments,
        p.has_credit_card_payment,
        p.has_voucher_payment

    from orders o
    left join order_items i on o.order_id = i.order_id
    left join payments p on o.order_id = p.order_id
)

select * from final