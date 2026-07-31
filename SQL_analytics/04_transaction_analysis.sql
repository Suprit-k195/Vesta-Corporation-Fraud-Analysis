-- ==============================================================================
-- 04_TRANSACTION_ANALYSIS.SQL: Amount Buckets & Extreme Outliers
-- ==============================================================================

-- 4.1 Risk distribution by dollar amount bands
SELECT 
    CASE 
        WHEN TransactionAmt < 50 THEN '01: Under $50'
        WHEN TransactionAmt BETWEEN 50 AND 100 THEN '02: $50 - $100'
        WHEN TransactionAmt BETWEEN 100.01 AND 500 THEN '03: $100.01 - $500'
        ELSE '04: Over $500'
    END AS amount_bucket,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS fraud_transactions,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM train_transaction
GROUP BY amount_bucket
ORDER BY amount_bucket;

-- 4.2 Top extreme purchase amounts by fraud status
SELECT 
    TransactionID, 
    TransactionAmt, 
    ProductCD, 
    isFraud
FROM train_transaction
ORDER BY TransactionAmt DESC
LIMIT 20;
