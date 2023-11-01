with dates as (

    -- generate date spine for all dates from 2017-01-01 to now
    -- these are the dates of interest for us

    select *
    
    from UNNEST(generate_date_array(DATE('2017-01-01'), current_date(), interval 1 day)) as _date

), transactions as (

    select * 

    from `analytics-take-home-test.company_4_datawarehouse_BW.fact_transactions`

), accounts as (

    select * 

    from `analytics-take-home-test.company_4_datawarehouse_BW.dim_accounts`

), users as (

    select * 

    from `analytics-take-home-test.company_4_datawarehouse_BW.dim_users`

), account_history_status as (

    select * 

    from `analytics-take-home-test.company_4_datawarehouse_BW.dim_accounts_status_history`


), transactions_users as (

    -- bring user_id into transactions data

    select *

    from transactions 

    left join accounts 
        on transactions.account_id = accounts.account_id

), cross_join as (

    -- get all dates we are interested in (ie the date spine) and compare those dates how long ago the transactions happened

    select 

        *
        , date_diff(_date, transaction_date, day) as date_difference

    from dates 

    cross join transactions_users


), active_dates as (

    -- bring back any users and dates where the transaction happened in the 7 days before the date of interest

    select 

        _date 
        , user_id 

    from cross_join

    where date_difference between 0 and 6

    group by 1,2 

    order by 2,1

), user_history_status as (

    -- get user_id against account_history_status 

    select  

      account_history_status.*
      , accounts.user_id

    from account_history_status

    left join accounts 
        on account_history_status.account_id = accounts.account_id

), flag_closed_accounts as (

    -- flag all accounts where they were closed within 1 hour of being opened

    select 

        user_id 
        , account_id
        ,  case when sum(case when (datetime_diff(_valid_to, _valid_from, second) < 3600 and status = 'open') then 1 else 0 end) > 0 then 'closed' end  as closed_accounts
        
    from user_history_status 

    group by 1,2

    order by 2 desc

), flag_closed_users as (

    --flag all users that only have closed accounts (given users can have multiple accounts)

    select 

    user_id
    , case when sum(case when closed_accounts = 'closed' then 0 else 1 end) = 0 then 'only_closed' end as closed_accounts_user

    from flag_closed_accounts

    group by 1


), users_with_open_accounts as (

    -- remove any users that only have closed accounts

    select  
        users.*

    from users 

    left join flag_closed_users
        on users.user_id = flag_closed_users.user_id

    where flag_closed_users.closed_accounts_user != 'only_closed'
        or flag_closed_users.closed_accounts_user is null


), all_dates_users as (

    -- get all dates of interest against all users of interest 
    -- this will be the scaffold to hang everything else off

    select 

        _date 
        , user_id

    from dates 

    cross join users_with_open_accounts


), combined as (

    select 

        all_dates_users._date
        , all_dates_users.user_id

        -- need to account for duplicate users hence using a sum of 1s to search for active and open 
        , case when sum(case when active_dates.user_id is not null then 1 else 0 end) > 0 then 'active' else 'inactive' end as activity_status 
        , case when sum(case when user_history_status.status = 'open' then 1 else 0 end) > 0 then 'open' else 'closed' end as account_status
        
        -- need to account for duplicate users hence searching for smallest accoun_created_at
        , min(accounts.account_created_at) as account_created_at

    from all_dates_users 

    -- join on data for those who have had activity in last 7 days 

    left join active_dates 
        on all_dates_users._date = active_dates._date 
        and all_dates_users.user_id = active_dates.user_id

    -- join on data about the status of the account

    left join user_history_status 
        on all_dates_users.user_id = user_history_status.user_id 
        and all_dates_users._date >= date(user_history_status._valid_from)
        and all_dates_users._date < coalesce(date(user_history_status._valid_to), '2100-01-01') -- coalesce to large date in future to ensure we include nulls in _valid_to

    -- join accounts to get account_created_at 
    
    left join accounts 
        on all_dates_users.user_id = accounts.user_id 

    group by 1,2

) , final as (

    select 

        md5(concat(_date, user_id)) as activity_status_surrogate_id
        , _date
        , user_id 
        , activity_status
        , account_status


    from combined

    -- delete dates when an account hasn't been opened yet
    -- allows for easier testing (no nulls should exist for account_status) and reduces data volumes 
    
    where _date >= date(account_created_at) 


) 

select * from final 




