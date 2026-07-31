-- ==============================================================================
-- 10_PRODUCT_ANALYSIS.SQL: Financial Loss Concentration (Pareto Loss Breakdown)
-- ==============================================================================

-- 10.1 Financial dollar loss and average ticket size exposure by product category
SELECT
    t.ProductCD,
    COUNT(*) AS total_transactions,
    SUM(t.isFraud) AS total_fraud_count,
    ROUND(SUM(CASE WHEN t.isFraud = 1 THEN t.TransactionAmt ELSE 0 END), 2) AS total_fraud_dollar_loss,
    ROUND(AVG(CASE WHEN t.isFraud = 1 THEN t.TransactionAmt ELSE NULL END), 2) AS avg_fraud_ticket_size,
    ROUND(AVG(CASE WHEN t.isFraud = 0 THEN t.TransactionAmt ELSE NULL END), 2) AS avg_legit_ticket_size
FROM train_transaction t
GROUP BY t.ProductCD
ORDER BY total_fraud_dollar_loss DESC;
