/*
1. What skills are required for the top-paying data analyst jobs?
2. Use the Top 10 highest-Paying Data Analyst roles from 1st query
3. Add the specific skills required for these roles
4. Why? It provides a Detailed look at which high-paying Jobs demand certain skills,
5. Helping job seekrs understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS(
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM    
    job_postings_fact
LEFT JOIN 
    company_dim ON job_postings_fact.company_id=company_dim.company_id
WHERE
    job_title_short='Data Analyst' AND
    job_location ='India' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 
    10
)

SELECT 
    top_paying_jobs.*,
    skills 
FROM
    top_paying_jobs
INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id =skills_dim.skill_id
ORDER BY
    salary_year_avg DESC