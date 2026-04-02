import pandas as pd
import random
from faker import Faker

# Initialize Faker
fake = Faker()

# Read the existing CSV
df = pd.read_csv('rawdata/olist_sellers_dataset.csv')

# Generate random data
n_rows = len(df)

# First names and family names
first_names = [fake.first_name() for _ in range(n_rows)]
family_names = [fake.last_name() for _ in range(n_rows)]

# Status categories
statuses = [random.choice(['junior', 'senior', 'manager', 'top management']) for _ in range(n_rows)]

# Salary between 50,000 and 130,000
salaries = [random.randint(50000, 130000) for _ in range(n_rows)]

# Add columns to dataframe
df['first_name'] = first_names
df['family_name'] = family_names
df['status'] = statuses
df['salary'] = salaries

# Save the updated CSV
df.to_csv('rawdata/olist_sellers_dataset.csv', index=False)

print(f"✅ Added 4 columns to {n_rows} rows!")
print(f"Columns: first_name, family_name, status, salary")
print(f"\nFirst 5 rows:")
print(df.head())
