Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

# Mise en place du staging et de la contractualisation dbt

### 1. Modèles de staging créés
6 tables de staging ont été implémentées :
- `stg_customers`
- `stg_orders`
- `stg_order_items`
- `stg_payments`
- `stg_products`
- `stg_sellers`

Chaque modèle :
- Lit la source depuis `{{ source('olist_raw', ...) }}`
- Renomme/dérive les colonnes
- Cast les dates/valeurs au bon type
- Ajoute `_loaded_at` pour le tracking

### 2. Documentation / contrat de schéma (`models/staging/_stg_schema.yml`)
- Fichier YAML généré et enrichi manuellement
- Description de chaque modèle + colonne
- `data_type` explicite pour chaque colonne
- Champs ajoutés : `purchase_at`, `shipping_cost`, `payment_amount`, etc.
- Colonne `_loaded_at` documentée partout

### 3. Tests de qualité ajoutés
Tests déclarés dans le YAML :
- `unique` (clés uniques)
- `not_null` (non-null)
- `relationships` (`stg_orders.customer_id → stg_customers.customer_id`)

### 4. Contrat de schéma activé
Sur les 6 modèles :
- `config.contract.enforced: true`
  
Cela empêche :
- ajout/suppression de colonne non déclarée
- modification de type non déclarée
- dérive entre SQL et YAML

### 5. Contrôle de fraîcheur des sources (`models/staging/_sources.yml`)
- `orders` : `loaded_at_field: order_purchase_timestamp`
- `warn_after: 48h`
- `error_after: 180j` (approx. 6 mois)
