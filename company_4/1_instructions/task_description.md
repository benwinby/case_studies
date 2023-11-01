# Task Description

## Introduction 

This task requires you to create two data models using real, anonymised data from our backend. We'd like to see how you approach the problem on a technical front, but also observe how you document your work and understand what you think makes a good data model. 

The aim is to: 
- Show us how you think and how you communicate your thoughts to others. 
- Demonstrate your technical skills with SQL and modelling. 
- Give insight into how you handle ambiguous problems and independent tasks. 

We're not expecting you to spend a month developing a perfect solution, we'd like this to be a reflection of how you work in the real world. 

## Prerequisites 
This project contains real data that has been anonymised. Please do not share this dataset with anyone. 

The only thing necessary to start this task is access to the company_4_datawarehouse dataset via the BigQuery console. 

If you can't access sample dataset via the BigQuery console, please get in touch with the Recruitment team. 

You may also find the BigQuery SQL documentation helpful.

## Project Outline 
The supplied dataset (company_4_datawarehouse) contains four tables: 
- account_created
- account_closed
- account_reopened
- account_transactions 

Each table is fully refreshed on a nightly basis from the append only logs. These logs are managed by Backend Engineers and will change over time as the backend systems changes. 

Use your intuition to interpret these source tables. Throughout the task, if anything is unclear you are free to make common sense assumptions. Please make any assumptions explicit as we value the process rather than the result. 

### Task 1: Accounts 

The business needs a very reliable and accurate data model that represents all the different accounts at Company 4. 

Your first task is to create a table using the existing data as outlined above. The most important requirements are that this model is accurate, complete, intuitive to use and well documented. 

After implementing the model, please outline five of the most important tests that you would implement to give you the confidence in the output of your process. For this example, you should assume that upstream tables will change and that source data is not validated using contracts. 

### Task 2: 7-day Active Users 

*7d_active_users represents the number of users that had a transaction over the last running 7 days, divided by all the users with at least one open account at that point.*

Company 4 needs to be able to analyse the activity of our users (remember, one user can be active across multiple accounts). 

In particular, we are looking at a metric aptly named 7d_active_users (defined above). The goal for this part is to build a data model that will enable analysts on the team to explore this data very quickly and without friction. 

Important requirements: 
- The data model should be intuitive to use for others, we should reduce the chances of misinterpreting the results. 
- The design should give people flexibility to answer many different questions, for example analyse the activity rate for certain age groups or for different signup cohorts (i.e. when the first account of this user was opened).
- Users with only closed accounts should be excluded from the metric calculation.
- The metric should be calculated for any given day of the year. 
- We want this data model to be historically consistent, i.e. if the active rate was 60% on the 2019-01-01 we should be always able to recalculate this number (its deterministic). 

## Submission 
Please submit your solutions to the above activity by attaching your SQL and documentation to an email. 
If you materialise your results in BigQuery, remember to let us know in which dataset we can find your data models. 

Any documentation that you produce should be easy to digest for anyone thats looking to understand the relationships between your tables. The task isn't graded based on the type of documentation that you provide but the clarity of the content. 
