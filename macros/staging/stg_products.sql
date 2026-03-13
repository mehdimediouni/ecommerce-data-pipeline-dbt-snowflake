with source as (
        select * from {{ source('olist_raw', 'products') }}
  ),
  renamed as (
      select
          {{ adapter.quote("PRODUCT_ID") }},
        {{ adapter.quote("PRODUCT_CATEGORY_NAME") }},
        {{ adapter.quote("PRODUCT_NAME_LENGHT") }},
        {{ adapter.quote("PRODUCT_DESCRIPTION_LENGHT") }},
        {{ adapter.quote("PRODUCT_PHOTOS_QTY") }},
        {{ adapter.quote("PRODUCT_WEIGHT_G") }},
        {{ adapter.quote("PRODUCT_LENGTH_CM") }},
        {{ adapter.quote("PRODUCT_HEIGHT_CM") }},
        {{ adapter.quote("PRODUCT_WIDTH_CM") }}

      from source
  )
  select * from renamed
    