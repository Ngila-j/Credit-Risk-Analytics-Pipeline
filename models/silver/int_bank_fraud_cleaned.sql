{{ config(materialized='table') }}

with base as (
    select * from {{ ref('stg_bank_fraud') }}
),

fraud_cases as (
    select * from base where is_fraud = true
),

non_fraud_cases as (
    select * from base where is_fraud = false
    -- Take a random sample equal to the number of fraud cases
    order by random() 
    limit (select count(*) from fraud_cases)
)

select * from fraud_cases
union all
select * from non_fraud_cases