import streamlit as st
import pandas as pd
import duckdb
import os
import joblib
from sklearn.ensemble import RandomForestClassifier

st.title("Credit Risk Fraud Detection Dashboard")
st.write("An end-to-end data engineering and machine learning pipeline demo built with dbt, DuckDB, and Streamlit.")

# 1. Sidebar for User Inputs (Features)
st.sidebar.header("Applicant Features")
applicant_income = st.sidebar.number_input("Applicant Income", value=50000, step=1000)
credit_risk_score = st.sidebar.number_input("Credit Risk Score", value=650, step=10)
name_email_similarity = st.sidebar.slider("Name Email Similarity", 0.0, 1.0, 0.5)
months_at_previous_address = st.sidebar.number_input("Months at Previous Address", value=12, step=1)
months_at_current_address = st.sidebar.number_input("Months at Current Address", value=24, step=1)

# Derived features used in the pipeline
address_tenure_diff = months_at_current_address - months_at_previous_address
is_low_similarity_score = 1 if name_email_similarity < 0.3 else 0

st.sidebar.write(f"**Engineered Feature (Address Tenure Diff):** {address_tenure_diff}")
st.sidebar.write(f"**Engineered Feature (Low Similarity):** {is_low_similarity_score}")

# 2. Train or Load Model on the Fly for the Demo
@st.cache_resource
def train_demo_model():
    # Connect to DuckDB or initialize a lightweight in-memory/local training
    con = duckdb.connect('local_data_lake.db', read_only=True)
    try:
        df = con.execute("SELECT * FROM main.int_bank_fraud_cleaned").df()
    except Exception:
        # Fallback dummy sample if dbt table isn't pre-built in cloud environment
        df = pd.DataFrame({
            'applicant_income': [50000, 30000, 80000],
            'credit_risk_score': [600, 500, 750],
            'name_email_similarity': [0.2, 0.8, 0.5],
            'months_at_previous_address': [10, 5, 36],
            'months_at_current_address': [20, 10, 48],
            'address_tenure_diff': [10, 5, 12],
            'is_low_similarity_score': [1, 0, 0],
            'is_fraud': [True, False, False]
        })
    con.close()

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

    clf = RandomForestClassifier(n_estimators=100, random_state=42)
    clf.fit(X, y)
    return clf

model = train_demo_model()

# 3. Prediction Button
if st.button("Evaluate Fraud Risk"):
    input_data = pd.DataFrame([[
        applicant_income,
        credit_risk_score,
        name_email_similarity,
        months_at_previous_address,
        months_at_current_address,
        address_tenure_diff,
        is_low_similarity_score
    ]], columns=[
        'applicant_income', 
        'credit_risk_score', 
        'name_email_similarity', 
        'months_at_previous_address', 
        'months_at_current_address',
        'address_tenure_diff', 
        'is_low_similarity_score'
    ])
    
    prediction = model.predict(input_data)[0]
    probability = model.predict_proba(input_data)[0][1]

    if prediction:
        st.error(f"⚠️ **High Risk:** This transaction is flagged as potential fraud! (Fraud Probability: {probability:.2f})")
    else:
        st.success(f"✅ **Low Risk:** This transaction appears legitimate. (Fraud Probability: {probability:.2f})")