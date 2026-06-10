CREATE TABLE IF NOT EXISTS github_clean (
    repo_id BIGINT PRIMARY KEY,
    repo_name VARCHAR(255),
    owner_login VARCHAR(255),
    language VARCHAR(100),
    stars INT,
    forks INT,
    url TEXT,
    processed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


TRUNCATE TABLE github_clean;

INSERT INTO github_clean (repo_id, repo_name, owner_login, language, stars, forks, url)

SELECT 
    CAST(repo_data->>'id' AS BIGINT) as repo_id,
    repo_data->>'name' as repo_name,
    repo_data->'owner'->>'login' as owner_login,
    repo_data->>'language' as language,
    CAST(repo_data->>'stargazers_count' AS INT) as stars,
    CAST(repo_data->>'forks_count' AS INT) as forks,
    repo_data->>'html_url' as url
FROM github_raw;

select * from github_clean;