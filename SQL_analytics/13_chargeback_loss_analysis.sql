-- ==============================================================================
-- 13_CHARGEBACK_LOSS_ANALYSIS.SQL: Net Chargeback & Penalty Exposure
-- ==============================================================================

-- 13.1 Net financial loss calculation factoring chargebacks and processor fees
SELECT 
    ProductCD,
    COUNT(*) AS total_chargeback_count,
    SUM(TransactionAmt) AS direct_fraud_loss,
    SUM(TransactionAmt + 15.00) AS total_financial_exposure
FROM train_transaction
WHERE isFraud = 1
GROUP BY ProductCD
ORDER BY total_financial_exposure DESC;
