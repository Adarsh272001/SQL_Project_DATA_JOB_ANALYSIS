/*
1. what are the top skills based on salry?
2. Look at the average salary associated with each skill for Data Analyst positons
3. Focuses on roles with specified salaries, regardless of location
4. Why? It reveals how different skills impact salary levels for Data Analyst and helps identify


 */


SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id =skills_dim.skill_id
WHERE
    job_title_short ='Data Analyst' AND
    salary_year_avg is NOT NULL
    --job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25