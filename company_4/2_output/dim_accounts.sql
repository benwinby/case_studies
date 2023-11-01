
with account_created as (

    select 
    
        account_id_hashed as account_id 
        , user_id_hashed as user_id
        , account_type 
        , created_ts as account_created_at
    
    from `analytics-take-home-test.company_4_datawarehouse.account_created`


), current_status as (

    -- get just current status

    select *

    from `analytics-take-home-test.company_4_datawarehouse_BW.dim_accounts_status_history`

    where _valid_to is null

), transactions as (

    -- get total transactions

    select 

        account_id 
        , sum(total_transactions) as total_transactions

    from `analytics-take-home-test.company_4_datawarehouse_BW.fact_transactions`

    group by 1

)


select 

    account_created.account_id 
    , account_created.user_id
    , account_created.account_type 
    , account_created.account_created_at
    , current_status.status as current_account_status
    , transactions.total_transactions

from account_created 

left join current_status 
    on account_created.account_id = current_status.account_id

left join transactions 
    on account_created.account_id = transactions.account_id
