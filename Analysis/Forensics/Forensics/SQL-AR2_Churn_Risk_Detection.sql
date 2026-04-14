/* ARTIFACT ID: SQL-AR2
DESCRIPTION: Subscription Churn-Risk Identification
OBJECTIVE: Flag accounts with declining usage or missing health checks.
*/

SELECT 
    account_id,
    account_name,
    contract_end_date,
    usage_drop_percentage,
    last_qbr_date
FROM 
    customer_success_data
WHERE 
    contract_end_date <= CURRENT_DATE + INTERVAL '90 days'
    AND (usage_drop_percentage > 20 OR last_qbr_date < CURRENT_DATE - INTERVAL '60 days');
