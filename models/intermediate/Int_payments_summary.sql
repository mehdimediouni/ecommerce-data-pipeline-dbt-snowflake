with payments as (
    select * from {{ ref('stg_payments') }}
),

aggregated as (
    select
        order_id,
        -- nombre de mensualités pour les commandes échelonnées
        max(payment_installments) as nb_installments,
        -- montant total payé pour la commande
        sum(payment_amount) as total_payment_value,
        -- nombre de paiements effectués pour la commande
        count(payment_sequence) as nb_payments,
        -- flag pour identifier si le payment a contenu une carte de crédit
        max(case when payment_type = 'credit_card' then 1 else 0 end) as has_credit_card_payment,
        -- flag pour identifier si le payment a contenu un voucher
        max(case when payment_type = 'voucher' then 1 else 0 end) as has_voucher_payment,

        max(_loaded_at) as _loaded_at
    from payments
    group by 1 
)

select * from aggregated