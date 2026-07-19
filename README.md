Welcome to your new dbt project!
Credit Risk Analytics Pipeline
🚀 Project Overview
This project serves as an end-to-end data engineering pipeline designed to automate the transformation and reporting of financial credit risk data. By leveraging a local data lake architecture, this pipeline provides streamlined, actionable insights for decision-making processes.

🛠 Tech Stack
Transformation: dbt for building modular and scalable data transformation models.

Database Engine: DuckDB for high-performance, local analytical processing.

Visualization/BI: Metabase for interactive data reporting and dashboarding.

📊 Key Features
Automated Data Modeling: Developed the mart_credit_risk_summary model to simplify complex financial calculations and ensure data consistency.

Pipeline Efficiency: Engineered a robust workflow that reduces manual reporting overhead in financial compliance tasks.

Interactive BI Integration: Connected to Metabase to visualize credit risk trends, enabling real-time monitoring of financial indicators.

📁 Repository Structure
/models: Contains all dbt SQL transformation models used to process raw data.

/dashboards: Contains documentation and screenshots of the Metabase visual analytics.

.gitignore: Configured to exclude local database files and environment-specific secrets.

📈 Impact
This pipeline demonstrates proficiency in modern data engineering practices, transitioning from manual, error-prone data handling to an automated, scalable infrastructure that supports reliable financial analytics.
### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
