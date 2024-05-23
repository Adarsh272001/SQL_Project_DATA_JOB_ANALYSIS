/*
1. What are the most in-demand skills for Data Analysts?
2. Join job postings to inner join table similar to query 2
3. Identify the top 5 in-demand skills for a Data Analyst
4. Focus on all Job Postings
5. Why? Retrieves the Top 5 skills with the Highest Demand in the job market,
Providing insights into the most baluable skills for job seekers
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id =skills_dim.skill_id
WHERE
    job_title_short ='Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5