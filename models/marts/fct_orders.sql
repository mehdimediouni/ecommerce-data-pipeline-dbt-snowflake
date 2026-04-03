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
        o.order_id,
        o.customer_id,
        o.order_status,
        o.order_purchase_timestamp,
        
        -- On ramène les infos des articles (depuis intermediate)
        i.total_items_price,
        i.total_shipping_cost,
        i.total_order_amount,
        i.nb_items,
        
        -- On ramène les infos des paiements (depuis intermediate)
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