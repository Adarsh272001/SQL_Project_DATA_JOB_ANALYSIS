/*
1. What are the most optimal skills to learn(aka skills which are in high-demand and high-paying )
2. Identify skills in high demand and associated with high average salaries for Data Analyst roles
3. Concentrated on remote postions with specified salaries
4. Why? Targets skills that offer job security (high dmenad) and financial benefits(high salries),
5. Offering strategic insights for career development in Data Analyst roles
*/

WITH skills_demand AS(
SELECT 
    skills_dim.skills,
    skills_dim.skill_id,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id =skills_dim.skill_id
WHERE
    job_title_short ='Data Analyst' AND
    salary_year_avg is NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id


), average_salary AS(
SELECT 
    skills_job_dim.skill_id,

    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id =skills_dim.skill_id
WHERE
    job_title_short ='Data Analyst' AND
    salary_year_avg is NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills_job_dim.skill_id

)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER Join average_salary ON skills_demand.skill_id=average_salary.skill_id
WHERE 
    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25

--rewriting the same query concisely

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0)AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short='Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id)>10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
