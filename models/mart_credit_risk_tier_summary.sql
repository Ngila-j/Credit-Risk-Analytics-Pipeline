{{ config(materialized='table') }}

with granular_summary as (
    select * from {{ ref('mart_credit_risk_summary') }}
)

select
    credit_risk_tier,
    sum(total_applications) as total_applications,
    sum(total_fraud_cases) as total_fraud_cases,
    -- Calculate rolled-up fraud rate
    round(
        (sum(total_fraud_cases) * 100.0) / nullif(sum(total_applications), 0), 
        4
    ) as overall_fraud_rate_percentage,
    round(avg(average_applicant_income), 4) as average_applicant_income
from granular_summary
group by 1
order by 
    case credit_risk_tier
        when 'Negative/No Score' then 1
        when 'Very Low Risk' then 2
        when 'Low Risk' then 3
        when 'Medium Risk' then 4
        when 'High Risk' then 5
        when 'Extreme/Critical Risk' then 6
        else 7
    end asc
