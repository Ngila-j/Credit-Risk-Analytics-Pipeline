{{ config(materialized='view') }}

with source_data as (
    select * from {{ ref('stg_bank_fraud') }}
)

select
    -- Cast columns explicitly for consistency
    cast(credit_risk_score as integer) as credit_risk_score,
    cast(is_fraud as boolean) as is_fraud,
    cast(applicant_income as double) as applicant_income
from source_data
