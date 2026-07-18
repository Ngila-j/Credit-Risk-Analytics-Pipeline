{{ config(materialized='table') }}

with silver_data as (
    select * from {{ ref('int_bank_fraud_cleaned') }}
),

credit_grouping as (
    select
        credit_risk_score,
        case
            when credit_risk_score < 0 then 'Negative/No Score'
            when credit_risk_score between 0 and 100 then 'Very Low Risk'
            when credit_risk_score between 101 and 200 then 'Low Risk'
            when credit_risk_score between 201 and 300 then 'Medium Risk'
            when credit_risk_score between 301 and 400 then 'High Risk'
            else 'Extreme/Critical Risk'
        end as credit_risk_tier,
        count(*) as total_applications,
        sum(case when is_fraud = true then 1 else 0 end) as total_fraud_cases,
        round(avg(applicant_income), 4) as average_applicant_income
    from silver_data
    group by 1, 2
)

select
    credit_risk_score,
    credit_risk_tier,
    total_applications,
    total_fraud_cases,
    round((total_fraud_cases * 100.0) / nullif(total_applications, 0), 4) as fraud_rate_percentage,
    average_applicant_income
from credit_grouping
order by credit_risk_score asc
