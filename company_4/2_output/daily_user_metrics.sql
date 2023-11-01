select 

  _date 
  , count(distinct case when activity_status = 'active' then user_id end) as total_active_users 
  , count(distinct case when account_status = 'open' then user_id end) as total_accounts_open
  , count(distinct case when activity_status = 'active' then user_id end)/ count(distinct case when account_status = 'open' then user_id end) as seven_day_active_users


 FROM `analytics-take-home-test.company_4_datawarehouse_BW.dim_user_activity_status`


where _date < '2020-09-01'

group by 1

order by 1 desc