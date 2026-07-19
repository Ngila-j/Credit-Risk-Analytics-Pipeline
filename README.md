Credit-Risk-Analytics-Pipeline
An end-to-end data engineering and machine learning pipeline designed to detect financial fraud. This project demonstrates the ability to build a robust ELT workflow using dbt for data transformation and Python (scikit-learn) for predictive modeling.

🚀 Project Overview
This pipeline addresses the common real-world challenge of class imbalance in credit risk datasets. By leveraging dbt to perform data-level balancing at the transformation layer and implementing feature engineering, I successfully improved the model's ability to identify fraudulent transactions.

🛠 Tech Stack
Transformation: dbt (data build tool)

Database: DuckDB

Modeling: Python, scikit-learn (Random Forest)

Version Control: Git & GitHub

📊 Model Performance
After implementing SQL-level undersampling and engineered features (address_tenure_diff, is_low_similarity_score), the model achieved the following performance on the test set:

Plaintext
              precision    recall  f1-score   support

       False       0.67      0.68      0.67      2180
        True       0.68      0.67      0.68      2232

    accuracy                           0.67      4412
   macro avg       0.68      0.68      0.67      4412
weighted avg       0.68      0.67      0.67      4412
🏗 Key Engineering Highlights
Data Pipeline: Developed a modular dbt project (Staging -> Intermediate/Silver -> Marts) to clean and transform raw bank data.

Addressing Imbalance: Solved the "0% recall" issue by moving data-level balancing (undersampling) into the SQL pipeline, ensuring the model trains on a 50/50 split of fraud vs. non-fraud cases.

Feature Engineering: Created derived features that capture behavioral red flags, significantly improving the predictive power of the model.
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
