-- ==============================================================================
-- 06_CARD_ANALYSIS.SQL: Card Networks, Card Types & Payment Profiling
-- ==============================================================================

-- 6.1 Transaction volume and fraud rate by card network (card4)
SELECT
    t.card4 AS card_network,
    COUNT(*) AS total_transactions,
    SUM(t.isFraud) AS fraud_transactions,
    ROUND(SUM(t.isFraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM train_transaction t
WHERE t.card4 IS NOT NULL AND t.card4 != ''
GROUP BY t.card4
ORDER BY fraud_rate_pct DESC;

-- 6.2 Fraud distribution by payment type (card6: Credit vs Debit)
SELECT
    t.card6 AS payment_type,
    COUNT(*) AS total_transactions,
    SUM(t.isFraud) AS fraud_transactions,
    ROUND(SUM(t.isFraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM train_transaction t
WHERE t.card6 IS NOT NULL AND t.card6 != ''
GROUP BY t.card6
ORDER BY fraud_rate_pct DESC;
