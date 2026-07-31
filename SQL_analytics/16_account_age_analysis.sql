-- ==============================================================================
-- 16_ACCOUNT_AGE_ANALYSIS.SQL: Account Tenure & Single-Order Exposure
-- ==============================================================================

-- 16.1 Assessing fraud distribution on first-time customer proxies (single-order accounts)
WITH customer_order_counts AS (
    SELECT 
        card1 AS customer_id,
        COUNT(*) AS total_lifetime_orders
    FROM train_transaction
    GROUP BY card1
)
SELECT 
    CASE 
        WHEN c.total_lifetime_orders = 1 THEN '01: First-Time / Single Order'
        WHEN c.total_lifetime_orders BETWEEN 2 AND 5 THEN '02: Emerging Customer (2-5 orders)'
        ELSE '03: Established Customer (>5 orders)'
    END AS customer_tenure_bucket,
    COUNT(t.TransactionID) AS total_transactions,
    SUM(t.isFraud) AS fraud_transactions,
    ROUND(SUM(t.isFraud) * 100.0 / COUNT(t.TransactionID), 2) AS fraud_rate_pct
FROM train_transaction t
JOIN customer_order_counts c ON t.card1 = c.customer_id
GROUP BY customer_tenure_bucket
ORDER BY customer_tenure_bucket;
