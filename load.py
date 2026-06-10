from sqlalchemy import create_engine,text
from dotenv import load_dotenv
import os
import json

load_dotenv()

def get_engine():
    DB_USER=os.getenv('DB_USER')
    DB_PASS=os.getenv('DB_PASS')
    DB_HOST=os.getenv('DB_HOST')
    DB_PORT=os.getenv('DB_PORT')
    DB_NAME=os.getenv('DB_NAME')
    

    connection_string=f"postgresql+psycopg2://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    return create_engine(connection_string)
    

def load_to_postgres(repos,engine):
    with engine.begin() as conn:

        for repo in repos:

            conn.execute(
                text("""
                    INSERT INTO github_raw (repo_data)
                    VALUES (:repo_data)
                """),
                {
                    "repo_data": json.dumps(repo)
                }
            )

    print(f"[SUCCESS] Loaded {len(repos)} repositories")    