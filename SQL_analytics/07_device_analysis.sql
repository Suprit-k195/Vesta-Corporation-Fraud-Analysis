-- ==============================================================================
-- 07_DEVICE_ANALYSIS.SQL: Device Types & Hardware-Sharing Audits
-- ==============================================================================

-- 7.1 Fraud rate comparison across primary device categories (Mobile vs Desktop)
SELECT
    i.DeviceType,
    COUNT(*) AS total_transactions,
    SUM(t.isFraud) AS fraud_transactions,
    ROUND(SUM(t.isFraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM train_transaction t
JOIN train_identity i ON t.TransactionID = i.TransactionID
WHERE i.DeviceType IS NOT NULL AND i.DeviceType != ''
GROUP BY i.DeviceType
ORDER BY fraud_rate_pct DESC;

-- 7.2 Device sharing audit (detecting hardware used by multiple accounts)
SELECT
    i.DeviceInfo,
    COUNT(DISTINCT t.card1) AS linked_unique_accounts,
    COUNT(*) AS total_transactions,
    SUM(t.isFraud) AS total_fraud_cases
FROM train_transaction t
JOIN train_identity i ON t.TransactionID = i.TransactionID
WHERE i.DeviceInfo IS NOT NULL AND i.DeviceInfo != ''
GROUP BY i.DeviceInfo
HAVING COUNT(DISTINCT t.card1) > 3
ORDER BY linked_unique_accounts DESC;
