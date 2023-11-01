SELECT 

  user_id 
  , count(distinct account_id) as total_accounts
  , count(distinct case when current_account_status = 'open' then account_id else null end) as total_open_accounts 
  , sum(total_transactions) as total_transactions

 FROM `analytics-take-home-test.company_4_datawarehouse_BW.dim_accounts` 

 group by 1