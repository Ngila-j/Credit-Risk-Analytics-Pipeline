-- This test fails if any fraud rate is negative
select
    fraud_rate_percentage
from {{ ref('mart_credit_risk_summary') }}
where fraud_rate_percentage < 0
