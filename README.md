# Library Management System — Data Engineering Project

## Business Problem
The library wants to analyze book issue trends, popular categories, late returns, and member behavior to improve operations and decision-making.

## Data Architecture
PostgreSQL (OLTP) → Python ETL → AWS S3 (Raw Zone) → Athena

## Phase 1: Full Load Batch ETL
- Designed normalized OLTP schema in PostgreSQL (Supabase)
- Built Python ETL to extract full tables
- Landed raw data in S3 partitioned by extraction date
- Followed zone-based architecture (raw)

## Tech Stack
- PostgreSQL (Supabase)
- Python (psycopg2, pandas, boto3)
- AWS S3
- Amazon Athena (next phase)
