-- ==============================================================================
-- 14_IP_GEOLOCATION_ANALYSIS.SQL: Operating System & Platform Profiling
-- ==============================================================================

-- 14.1 Cross-referencing transaction identity to flag high-risk platforms
SELECT 
    i.id_30 AS operating_system,
    COUNT(*) AS total_transactions,
    SUM(t.isFraud) AS fraud_count,
    ROUND(SUM(t.isFraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM train_transaction t
JOIN train_identity i ON t.TransactionID = i.TransactionID
WHERE i.id_30 IS NOT NULL AND i.id_30 != ''
GROUP BY i.id_30
ORDER BY fraud_rate_pct DESC;
