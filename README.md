# Introduction
 
 This project aims to find out  and explore the job markt for Data Analyst role.

SQL queries: [project_sql folder](/project_sql/)

# Questions I answered 

1. What are the **Top-paying jobs** for my role?
2. What are the **skills** required for these **top-paying role**?
3. What are the most **in-demand skills** for my role?
4. What are the **top skills based on salary** for my role?
5. What are the most **optmial skills** to learn?

**Optimal: High Demand and High Paying
Role: Data Analyst**

link:[preview.sql](/project_sql/preview.sql)

#Tools used  

-**SQL**: Allowing me to query the data base and find critical insights

-**PostgreSQL**: Database management sustem ideal for handling job postings data  

-**Visual Studio Code**: As an IDE conncected with the database for executing SQL queries  

-**Git and GitHub**: Essential for version control and sharing my SQL project   


# Analysis
Each query in this project is aimed at investigationg specific aspect of the Data Analyst roles available in the job market.

Here's I approached each question:

### 1. Top Paying Data Analyst Jobs
```sql
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
```
Here's the breakdown of what I found:
- Top Salaries: The highest-paying roles are "Senior Business & Data Analyst" and "Sr. Enterprise Data Analyst," with average annual salaries above $118,000.
- Salary Range: Salaries range from $64,800 to $119,250, showing significant variation based on role and specialization.
-  Full-time Dominance: Nine out of the ten roles are full-time positions, indicating a strong preference for full-time employment in data analytics roles.
- Diverse Specializations: Roles vary across multiple specializations such as HR, financial, healthcare, business intelligence, and AI research, reflecting the broad application of data analytics skills across different sectors.

### Top-paying job skills

```sql
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
```
![Top Paying Roles](/assets/top_skill_count.png)
The Bar graph visualizes the top 20 salaries for Data Analysts; I generated it using Google Colab

Here's the Breakdown of what I found in this query

- The analysis reveals that SQL and Excel are foundational skills for high-paying data analyst roles in India. 
- Advanced technical skills, including cloud platforms, programming languages, and data visualization tools, significantly enhance earning potential. 
- Proficiency in collaboration and project management tools is also crucial for securing top-tier positions.

### Top Demanded Skills

```sql
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
```

  |  Skills	    |Demand Count|
  |  -----------|------------|
  |  SQL	    |      7291  |
  |  Excel	    | 4611       |
  |  Python	    | 4330       |
  |  Tableau    |	3745     |
  |  Power BI   |2609        |

  The Table displays information of most in_demand skill for Data Analysts roles with SQL topping the list.

  ### Top Paying Skills

```sql
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
```
Here a Bar chart that shows the results

![Top Paying Skills](assets\top_paying_skills.png)

Here's a breakdown of insights obtained using this query

- Specialized Technologies : Skills like SVN, Solidity, and Couchbase boast exceptionally high average salaries, underscoring the demand for expertise in niche areas like version control systems, blockchain development, and NoSQL databases.

- Programming Languages/Frameworks: Golang, MXNet, Keras, PyTorch, and Scala are among the top-paying skills, emphasizing the significance of proficiency in programming languages and machine learning frameworks, indicating lucrative career opportunities in these fields.

- Infrastructure/DevOps Tools: VMware, Terraform, Kafka, and Ansible correlate with high average salaries, reflecting the value of skills in infrastructure management, automation, and orchestration. Professionals adept in these areas are in high demand for deploying and managing complex IT infrastructures.

- Emerging Technologies: Twilio, GitLab, Hugging Face, as well as platforms like Notion and Atlassian, offer competitive average salaries, signaling opportunities in communication APIs, collaborative software development, and natural language processing (NLP) tools.

### Optimal Skills

This query lists skills which are both in high-demand and have high salary as well for Data Analysts roles.

```sql
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
```
![Optimal Skills](assets\optimal_skills.png)

- Diverse Skill Set: The list comprises a diverse set of skills, including both programming languages (e.g., Go, Java, Python, R, JavaScript, C++) and various data management and analytics platforms (e.g., Snowflake, BigQuery, Redshift, SQL Server).

- Cloud Platforms Dominance: Cloud platforms such as Azure and AWS, along with associated tools like BigQuery and Redshift, are in high demand, reflecting the industry's shift towards cloud-based solutions for data storage, processing, and analysis.

- Visualization Tools: Tableau and Looker emerge as critical skills, indicating the importance of data visualization in deriving insights and making data-driven decisions across various industries.

- Data Processing and Analytics Frameworks: Technologies like Hadoop, Spark, and SSIS are essential for data processing and integration, suggesting a continued demand for professionals with expertise in handling big data and orchestrating complex data workflows.

# What I learned 
- I learned a lot of concepts of sql basics and advanced, making complex queries , joining diffrent tables and finding insights, using aggregate functions like COUNT(),AVG() to summarize the results, defining CTE's, connecting to Database using drivers

- I also learned using git and Github for version control and management , branching and merging for collaboration.

# Conclusions
### Insights

1. **Top Paying Data Analyst Jobs**: Identified roles like "Senior Business & Data Analyst" and "Sr. Enterprise Data Analyst" with average salaries exceeding $118,000, showcasing lucrative opportunities.

2. **Top Paying Job Skills**: Found SQL and Excel as foundational skills for high-paying data analyst roles in India, while advanced technical skills like cloud platforms and programming languages significantly enhance earning potential.

3. **Top Demanded Skills**: SQL emerged as the most in-demand skill for Data Analyst roles, followed by Excel, Python, Tableau, and Power BI, based on job postings with work-from-home options.

4. **Top Paying Skills**: Specialized technologies like SVN, Solidity, and Couchbase command high average salaries, indicating demand for expertise in niche areas. Additionally, programming languages/frameworks and infrastructure/DevOps tools also offer lucrative opportunities.

5. **Optimal Skills**: Revealed a diverse skill set comprising programming languages, cloud platforms, visualization tools, and data processing/analytics frameworks, emphasizing their importance in driving demand for data analysts.

### Closing Remarks

The Project enhanced my SQL concepts and query building and also provides a lot of insight specifically for '**Data Analyst Job Market**' Using these insights job seekers can know the most in-demand and high-paying skills required for specific roles within the data analyst job market and priortize their skill development and job search efforts.

Using the Tables that I have built from the csv files one can explore any other job market of his/her choice. However this project higlights the Data analyst job market and highlights the importance of continuous learning and adaptaion within the data analytics field.
