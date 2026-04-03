with source as (
    select * from {{ source('olist_raw', 'products') }}
),

renamed as (
    select
        product_id,
       
        upper(replace(product_category_name, '_', ' ')) as category_name,
        
        product_name_lenght as name_length,
        product_description_lenght as description_length,
        
        product_photos_qty as photo_count,
        product_weight_g as weight_g,
        product_length_cm as length_cm,
        product_height_cm as height_cm,
        product_width_cm as width_cm,
        
        _loaded_at
    from source
),

enriched as (
    select 
        * exclude (_loaded_at),
        
        -- volume
        (length_cm * height_cm * width_cm) / 1000 as volume_dm3,
        
        _loaded_at
    from renamed
)

select * from enriched