import pandas as pd
from sqlalchemy import create_engine

# =========================
# DATABASE CONFIG
# =========================
DB_USER = "postgres"
DB_PASSWORD = "4512"  
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "ecommerce_db"

# =========================
# CREATE ENGINE
# =========================
engine = create_engine(
    f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

# =========================
# ETL PROCESS
# =========================
def run_etl():
    try:
        print("Loading dataset...")
        df = pd.read_csv("data/orders.csv")
        print("Original shape:", df.shape)

        # =========================
        # TRANSFORMATION
        # =========================
        print("Cleaning data...")

        # 1. Remove duplicates
        df.drop_duplicates(inplace=True)

        # 2. Handle missing values
        df['days_since_prior_order'] = df['days_since_prior_order'].fillna(0)

        # Drop rows with critical missing values
        df.dropna(subset=['order_id', 'user_id'], inplace=True)

        # 3. Convert data types
        df['order_id'] = df['order_id'].astype(int)
        df['user_id'] = df['user_id'].astype(int)
        df['order_number'] = df['order_number'].astype(int)

        # 4. Add new feature (business logic)
        df['is_weekend'] = df['order_dow'].apply(lambda x: 1 if x in [0, 6] else 0)

        print("Cleaned shape:", df.shape)
        print("Transformation complete")

        # =========================
        # LOAD
        # =========================
        print("Loading into PostgreSQL...")

        df.to_sql(
            "orders",
            engine,
            if_exists="replace",   # first run only
            index=False,
            chunksize=50000
        )

        print("✅ Data loaded successfully!")

    except Exception as e:
        print("ETL Error:", e)


# =========================
# RUN
# =========================
if __name__ == "__main__":
    run_etl()