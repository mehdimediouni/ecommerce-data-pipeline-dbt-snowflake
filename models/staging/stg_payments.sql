with source as (
    select * from {{ source('olist_raw', 'payments') }}
),

renamed as (
    select
        order_id,
        payment_sequential as payment_sequence,
        payment_type,
        payment_installments,
        cast(payment_value as float) as payment_amount,
        _loaded_at
    from source
)

select * from renamed