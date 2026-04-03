with source as (
    select * from {{ source('olist_raw', 'payments') }}
),

renamed as (
    select
        order_id,
        payment_sequential as payment_sequence,
        upper(payment_type) as payment_type,
        payment_installments,
        cast(payment_value as float) as payment_amount,
        _loaded_at
    from source
),

enriched as (
    select
        * exclude (_loaded_at),
       
       -- Flag pour identifier les payment échelonnés
        case 
            when max(payment_installments) over (partition by order_id) > 1 then true 
            else false 
        end as is_installment_order,

        -- Montant total de la commande
        sum(payment_amount) over (partition by order_id) as total_order_payment_amount,


        _loaded_at
    from renamed
)

select * from enriched