# GitHub ELT Pipeline Project

This is a simple data engineering project that extracts trending repositories from the GitHub API and loads them into a PostgreSQL database. 

It uses the **Medallion Architecture** (Bronze, Silver, Gold layers) to process the data step-by-step.

## How it works

The data pipeline is split into three main layers:

### 1. Bronze Layer (Raw Data)
The Python script hits the GitHub API, takes the entire raw JSON response, and dumps it straight into a `github_raw` table in Postgres. Storing the raw JSON first is a safe bet—that way, if GitHub ever changes their API format, the pipeline doesn't crash and the original data is always safely stored.

### 2. Silver Layer (Clean Data)
A giant JSON blob isn't great for analysis, so a SQL script (`silver.sql`) pulls out only the useful fields (like the repo name, owner, programming language, and number of stars/forks) and puts them into a clean, normal table called `github_clean`.

### 3. Gold Layer (Business Metrics)
Finally, another SQL script (`gold.sql`) does some aggregations on the clean data. For example, it groups the repositories by programming language to count up the total stars and total repos. This table (`gold_language_metrics`) is basically ready to be hooked up to a dashboard.

## Tech Stack
- **Python** (for pulling the data and pushing it to the db)
- **PostgreSQL** (for storing all the tables)

## How to run it

1. Create a `.env` file in the same folder and add your credentials like this:
   ```env
   GITHUB_TOKEN="your_github_token"
   DB_USER="postgres"
   DB_PASS="your_password"
   DB_HOST="localhost"
   DB_PORT="5432"
   DB_NAME="your_database_name"
   ```

2. Install the required python packages:
   ```bash
   pip install requests python-dotenv sqlalchemy psycopg2-binary
   ```

3. Run the python script to fetch the data and load it into the Bronze table:
   ```bash
   python main.py
   ```

4. Open up your PostgreSQL terminal (or pgAdmin) and run the scripts in the `queries/` folder:
   - Run `queries/silver.sql` to clean the data.
   - Run `queries/gold.sql` to calculate the metrics.
