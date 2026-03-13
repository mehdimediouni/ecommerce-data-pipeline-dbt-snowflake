with source as (
        select * from {{ source('olist_raw', 'payments') }}
  ),
  renamed as (
      select
          {{ adapter.quote("ORDER_ID") }},
        {{ adapter.quote("PAYMENT_SEQUENTIAL") }},
        {{ adapter.quote("PAYMENT_TYPE") }},
        {{ adapter.quote("PAYMENT_INSTALLMENTS") }},
        {{ adapter.quote("PAYMENT_VALUE") }}

      from source
  )
  select * from renamed
  

  with source as (
    select * from {{ source('olist_raw', 'payments') }}
),

renamed as (
    select
        order_id,
        payment_sequential as payment_sequence,
        payment_type,
        payment_installments,
        cast(payment_value as float) as payment_amount
    from source
)

select * from renamed