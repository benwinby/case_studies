
with account_created as (

    select * from `analytics-take-home-test.company_4_datawarehouse.account_created`

), account_closed as (

    select * from `analytics-take-home-test.company_4_datawarehouse.account_closed`

), account_reopened as (

    select * from `analytics-take-home-test.company_4_datawarehouse.account_reopened`

), status_table as (

    -- create a table with all the events combined 

    select  

        created.account_id_hashed as account_id
        , created.created_ts as _valid_from 
        , 'open' as status

    from account_created created

    union all 

    select 

        closed.account_id_hashed as account_id 
        , closed.closed_ts as _valid_from 
        , 'closed' as status

    from account_closed closed

    union all 

    select 

        reopened.account_id_hashed as account_id 
        , reopened.reopened_ts as _valid_from 
        , 'open' as status

    from account_reopened reopened

) , statuses as (

    -- order events based on their date and then set _valid_to date based on when the next event starts
    
    select 

        account_id 
        , status 
        , _valid_from 
        , lead(_valid_from)over(partition by account_id order by _valid_from asc) as _valid_to 

    from status_table 

    order by account_id 

), collapse_duplicate_rows as (

    -- collapse rows where the status doesn't changes (ie goes from closed to closed) into a single row
    -- get details of the relevant  

    select 

        * 
        , lead(status)over(partition by account_id order by _valid_from asc) as next_status 
        , lag(status)over(partition by account_id order by _valid_from asc) as previous_status 
        , lag(_valid_from)over(partition by account_id order by _valid_from asc) as previous_valid_from

    from statuses 

) , final as (

    -- for the 2nd row of duplicate set the _valid_from date to be that of the 1st row

    select 
        
        account_id 
        , status 
        , case when previous_status = status then previous_valid_from else _valid_from end as _valid_from
        , _valid_to

    from collapse_duplicate_rows

    where 1=1

    -- drop the 1st row of the duplicate

    and (status != next_status or next_status is null)

    order by account_id

)

select 


    md5(concat(account_id, _valid_from)) as account_status_surrogate_id -- create a surrogate key
    , account_id 
    , _valid_from 
    , _valid_to 
    , status  

from final 