-- ==============================================================================
-- 03_FRAUD_OVERVIEW.SQL: Portfolio Baselines & Category Risk Dispersion
-- ==============================================================================

-- 3.1 Overall fraud rate
SELECT 
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS total_fraud_transactions,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 2) AS baseline_fraud_rate_pct
FROM train_transaction;

-- 3.2 Category overall risk dispersion across product lines
SELECT 
    ProductCD,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS fraud_count,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 2) AS product_fraud_rate_pct
FROM train_transaction
GROUP BY ProductCD
ORDER BY product_fraud_rate_pct DESC;
