CREATE TABLE IF NOT EXISTS gold_language_metrics (
    language VARCHAR(100) PRIMARY KEY,
    total_repos INT,
    total_stars BIGINT,
    avg_stars INT,
    total_forks BIGINT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

TRUNCATE TABLE gold_language_metrics;

INSERT INTO gold_language_metrics (language, total_repos, total_stars, avg_stars, total_forks)
SELECT 
    COALESCE(language, 'Unknown') as language,
    COUNT(repo_id) as total_repos,
    SUM(stars) as total_stars,
    ROUND(AVG(stars)) as avg_stars,
    SUM(forks) as total_forks
FROM github_clean
GROUP BY language
ORDER BY total_stars DESC;
    

SELECT * FROM gold_language_metrics;
