-- ==============================================================================
-- 05_CUSTOMER_ANALYSIS.SQL: Customer Proxy Volume & Purchase Frequency
-- ==============================================================================

-- 5.1 Volume tracking: Top customer proxies (card1) ranked by total spend
SELECT
    t.card1 AS customer_id,
    COUNT(*) AS total_transactions,
    SUM(t.isFraud) AS total_fraud_cases,
    ROUND(SUM(t.TransactionAmt), 2) AS total_spend
FROM train_transaction t
GROUP BY t.card1
ORDER BY total_spend DESC
LIMIT 20;

-- 5.2 Repeat offender identification across customer proxies
SELECT
    t.card1 AS customer_id,
    COUNT(*) AS total_orders,
    SUM(t.isFraud) AS total_fraud_orders,
    ROUND(SUM(t.isFraud) * 100.0 / COUNT(*), 2) AS account_fraud_rate
FROM train_transaction t
GROUP BY t.card1
HAVING SUM(t.isFraud) >= 3
ORDER BY total_fraud_orders DESC;
