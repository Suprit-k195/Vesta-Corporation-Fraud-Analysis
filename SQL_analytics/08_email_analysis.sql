-- ==============================================================================
-- 08_EMAIL_ANALYSIS.SQL: Purchaser vs Recipient Domain Discrepancies
-- ==============================================================================

-- 8.1 Top risk purchaser email domains (P_emaildomain)
SELECT
    t.P_emaildomain,
    COUNT(*) AS total_transactions,
    SUM(t.isFraud) AS fraud_transactions,
    ROUND(SUM(t.isFraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM train_transaction t
WHERE t.P_emaildomain IS NOT NULL AND t.P_emaildomain != ''
GROUP BY t.P_emaildomain
HAVING COUNT(*) >= 50
ORDER BY fraud_rate_pct DESC;

-- 8.2 Purchaser vs Recipient email mismatch risk comparison
SELECT
    CASE 
        WHEN t.P_emaildomain = t.R_emaildomain THEN 'Matching Domains'
        WHEN t.R_emaildomain IS NULL OR t.R_emaildomain = '' THEN 'No Recipient Email'
        ELSE 'Mismatched Domains'
    END AS domain_match_status,
    COUNT(*) AS total_transactions,
    SUM(t.isFraud) AS fraud_transactions,
    ROUND(SUM(t.isFraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM train_transaction t
GROUP BY domain_match_status
ORDER BY fraud_rate_pct DESC;
