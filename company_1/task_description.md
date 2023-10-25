# Task Description

Congratulations on reaching this stage of the recruitment process! This task is designed to assess your analytical skills and problem-solving capabilities.

## Timeframes:
Upon receiving the email containing the challenge details, your mission begins! You will have **24 hours** to analyze the given problem thoroughly and present your results. 

## Requirements:
We encourage you to leverage any analytical tools you are comfortable with for parsing and analyzing the provided data.
To ensure a comprehensive evaluation, we kindly request that you showcase your work and code. Your methodology, assumptions, and data processing steps are crucial aspects we will be looking for in your submission.

## Presentation Format:
Along with your analysis, we ask you to prepare a visually engaging presentation in PDF, Keynote, or PowerPoint format. Structuring your findings and outcomes clearly will enhance the impact of your results. Feel free to be creative, but remember to maintain a professional approach and keep in mind that we might ask you to present your findings in the next step of the recruitment process.

## Business context
Our clients may add funds to their account using their credit and debit cards. We have partnered with Globepay to process all of these account funding credit and debit card transactions.

Globepay is an industry-leading global payment processor and is able to process payments in many currencies from cards domiciled in many countries. We have connectivity into Globepay using their API. Our clients provide their credit and debit details within our web application, which then pass those credentials along with any relevant transaction details to Globepay for processing.

## Problem
We are experiencing a decline in the acceptance rate of credit and debit card payments processed by Globepay in the recent period. The “acceptance rate” is defined as the number of accepted transactions divided by the total attempted transactions and theamount is in local currency.

Relevant files:
- globepay_acceptance_report.csv
- globepay_chargeback_report.csv
- globepay_api.html


# Tasks

## Task #1
*(Note - This task aims to test your Analytics skills)*

Please create a comprehensive report (presentation/keynote/PDF) that covers the following points:
- Present the volume of declined payments in USD
- Analyse the root causes for the decline in the acceptance rate
- Provide well-justified solutions, recommendations, and next steps that you would take if given
more time, additional data, and deeper business knowledge.

## Task #2
*(Note - This task aims to test your SQL skills)*

Working on the same dataset, please provide SQL queries and their outcome to answer the
following questions:
- Calculate and present the acceptance rate over time.
- List the countries where the amount (in dollars) of declined transactions went over $25M
- Identify transactions from the Acceptance report that are missing chargeback data.

## Task #3
*(Note - This task aims to test your data modeling skills. Feel free to use any data modeling
techniques, as we use dbt for our data modeling)*

Imagine the two provided datasets as source tables in a production database. Please provide a data
lineage of the data pipeline and design appropriate data layers for this case. Briefly describe what is
the underlying logic of every layer and why you chose it.

You should include :
- Ingestion/source table(s)
- Transformation table(s) - you can have multiple layers/tables as required
- Analytics table(s) (the final table/s which are going to be used from the end users and in the BI
tool) - Please present the structure of your final table(s) with all the columns/fields you would like
to include, along with their format; e.g. | col_name1 | col_name2 | col_name3| etc.)

## Task #4
*(Note - This task aims to test your A/B testing capabilities. We want to assess your general
knowledge of product experimentation, so please stick to the basics).*

Considering the previous tasks, propose an A/B test to optimize the feature's performance. Feel free to choose any aspect you find potentially useful to test.
 Additionally, please outline the steps you would take to ensure a statistically significant experiment while avoiding common pitfalls.

