{{ config(materialized='view') }}

with source_data as (
    select * from {{ source('minio_lake', 'bank_fraud_base') }}
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
    cast(current_address_months_count as integer) as months_at_current_address

from source_data