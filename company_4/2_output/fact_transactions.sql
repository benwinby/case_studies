SELECT 

  md5(concat(account_id_hashed, date)) as transactions_surrogate_id
  , account_id_hashed as account_id 
  , date as transaction_date 
  , sum(transactions_num) as total_transactions 

FROM `analytics-take-home-test.company_4_datawarehouse.account_transactions` 

group by 1,2,3

order by 3 desc