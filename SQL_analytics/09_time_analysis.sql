-- ==============================================================================
-- 09_TIME_ANALYSIS.SQL: 24-Hour Cycles & Off-Peak Velocity Patterns
-- ==============================================================================

-- 9.1 Hourly distribution of transaction volume and fraud rate (24-Hour Cycle)
SELECT
    FLOOR((t.TransactionDT / 3600) % 24) AS hour_of_day,
    COUNT(*) AS total_transactions,
    SUM(t.isFraud) AS fraud_transactions,
    ROUND(SUM(t.isFraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM train_transaction t
GROUP BY hour_of_day
ORDER BY hour_of_day ASC;
