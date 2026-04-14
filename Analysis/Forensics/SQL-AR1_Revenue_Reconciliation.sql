/* ARTIFACT ID: SQL-AR1
DESCRIPTION: Cross-Object Reconciliation (CRM vs. Billing)
OBJECTIVE: Identify "Closed-Won" leakage where contract value > invoiced value.
IMPACT: Foundation of the $3.5M Recovery Project.
*/

SELECT 
    crm.opp_id,
    crm.account_name,
    crm.close_date,
    crm.amount AS expected_revenue,
    finance.total_invoiced,
    -- Calculating the 'Leakage' or 'Revenue at Risk'
    (crm.amount - COALESCE(finance.total_invoiced, 0)) AS revenue_leakage
FROM 
    enterprise_crm_ops.opportunities AS crm
LEFT JOIN 
    finance_ops.invoices AS finance 
    ON crm.opp_id = finance.opp_id
WHERE 
    crm.stage = 'Closed-Won'
    AND (crm.amount > finance.total_invoiced OR finance.total_invoiced IS NULL)
ORDER BY 
    revenue_leakage DESC;
