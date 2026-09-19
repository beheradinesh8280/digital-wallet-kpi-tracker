import pandas as pd


# 1. Load dataset
file_path = "Transaction.csv"

df = pd.read_csv(file_path)

print("Original shape:", df.shape)
print("\nColumns:")
print(df.columns.tolist())


# 2. Check missing values
print("\nMissing values:")
print(df.isnull().sum())


# 3. Check duplicate records
duplicate_count = df.duplicated().sum()
print("\nDuplicate records:", duplicate_count)


# 4. Remove duplicate records
df = df.drop_duplicates()


# 5. Standardize column names
df.columns = (
    df.columns
    .str.strip()
    .str.lower()
    .str.replace(" ", "_")
)


# 6. Convert transaction date
if "transaction_date" in df.columns:
    df["transaction_date"] = pd.to_datetime(
        df["transaction_date"],
        errors="coerce"
    )


# 7. Validate transaction amount
if "amount" in df.columns:
    df["amount"] = pd.to_numeric(
        df["amount"],
        errors="coerce"
    )

    invalid_amounts = df[
        (df["amount"].isna()) |
        (df["amount"] <= 0)
    ]

    print("\nInvalid amount records:", len(invalid_amounts))


# 8. Final data-quality summary
print("\nFinal shape:", df.shape)

print("\nFinal missing values:")
print(df.isnull().sum())


# 9. Export cleaned dataset
output_file = "Transaction_Cleaned.csv"

df.to_csv(output_file, index=False)

print(f"\nCleaned dataset exported to: {output_file}")