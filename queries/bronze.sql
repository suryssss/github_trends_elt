CREATE TABLE github_raw(
    id SERIAL PRIMARY KEY,
    repo_data JSONB,
    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


select * from github_raw