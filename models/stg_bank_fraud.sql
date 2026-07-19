{{ config(materialized='view') }}

-- Pointing to your local seed instead of the external S3 bucket
with source_data as (
    select * from {{ ref('bank_fraud_base') }}
)

select
    -- Primary key / identifiers
    cast(fraud_bool as boolean) as is_fraud,
    
    -- Numerical characteristics
    cast(income as double) as applicant_income,
    cast(credit_risk_score as integer) as credit_risk_score,
    cast(name_email_similarity as double) as name_email_similarity,
    
    -- Address history indicators
    cast(prev_address_months_count as integer) as months_at_previous_address,
    cast(current_address_months_count as integer) as months_at_current_address,
    
    -- New Engineered Features
    (cast(prev_address_months_count as integer) - cast(current_address_months_count as integer)) as address_tenure_diff,
    case when cast(name_email_similarity as double) < 0.2 then 1 else 0 end as is_low_similarity_score

from source_data