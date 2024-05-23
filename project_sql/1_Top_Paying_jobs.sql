/* 
1. What are Top-paying Data Analyst Jobs?
2. Identify the Top 10 highest-paying Business Analyst roles that are available remotely.
3. Focuses on job postings with specified salaries (remove null values)
4. Why? Highlight the top-paying opportunities for Business Analysts,offering insights into 
*/

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