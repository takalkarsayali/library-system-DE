import os
import psycopg2
import pandas as pd
import boto3
from datetime import datetime
from dotenv import load_dotenv

load_dotenv()

# CONFIG
DB_CONFIG = {
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT"),
    "database": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD")
}

AWS_REGION = os.getenv("AWS_REGION")
S3_BUCKET = os.getenv("S3_BUCKET")

TABLES = ["authors", "categories", "books", "members", "transactions"]

# CONNECTIONS
def get_db_connection():
    return psycopg2.connect(**DB_CONFIG)

def get_s3_client():
    return boto3.client("s3", region_name=AWS_REGION)

# EXTRACTION LOGIC
def extract_table(table_name, conn, s3_client):
    print(f"Extracting table: {table_name}")

    query = f"SELECT * FROM {table_name};"
    df = pd.read_sql(query, conn)

    extraction_date = datetime.utcnow().strftime("%Y-%m-%d")
    s3_key = f"raw/{table_name}/extraction_date={extraction_date}/{table_name}.csv"

    df.to_csv(f"/tmp/{table_name}.csv", index=False)

    s3_client.upload_file(
        f"/tmp/{table_name}.csv",
        S3_BUCKET,
        s3_key
    )

    print(f"Uploaded {len(df)} rows to s3://{S3_BUCKET}/{s3_key}")

# MAIN
def main():
    conn = get_db_connection()
    s3_client = get_s3_client()

    for table in TABLES:
        extract_table(table, conn, s3_client)

    conn.close()
    print("Extraction completed successfully.")

if __name__ == "__main__":
    main()
