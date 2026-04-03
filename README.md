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
- Ajoute quelques calculs statistiques pour soulager les requettes sur le mart

### 2. Documentation / contrat de schéma (`models/staging/_stg_schema.yml`)
- Fichier YAML généré avec Copilot et enrichi manuellement
- Description de chaque modèle + colonne
- `data_type` explicite pour chaque colonne

### 3. Tests de qualité ajoutés
Tests unitaires (unique, not null, accepted valued, relationship) et singulier (from dbt.utils) intégrés et déclarés dans le YAML pour augmenter la qualité et la fiabilité des données


### 4. Contrat de schéma activé
Sur les 6 modèles :
- `config.contract.enforced: true`
  
Cela empêche :
- ajout/suppression de colonne non déclarée
- modification de type non déclarée
- dérive entre SQL et YAML


