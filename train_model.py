import duckdb
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report

# 1. Connect to the local DuckDB database
con = duckdb.connect('local_data_lake.db')

# 2. Pull the balanced data from your new int_bank_fraud_cleaned table
df = con.execute("SELECT * FROM main.int_bank_fraud_cleaned").df()

# 3. Prepare features and target
X = df[[
    'applicant_income', 
    'credit_risk_score', 
    'name_email_similarity', 
    'months_at_previous_address', 
    'months_at_current_address',
    'address_tenure_diff', 
    'is_low_similarity_score'
]] 
y = df['is_fraud']

# 4. Train the model
# Since the dataset is balanced via SQL, we use a standard classifier
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
clf = RandomForestClassifier(
    n_estimators=100,
    random_state=42
)
clf.fit(X_train, y_train)

# 5. Evaluate
predictions = clf.predict(X_test)
print("Classification Report with Balanced Dataset (SQL-level):")
print(classification_report(y_test, predictions))

con.close()