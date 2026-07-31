-- ==============================================================================
-- 15_ADDRESS_VERIFICATION_ANALYSIS.SQL: Recipient Type & Mismatch Audits
-- ==============================================================================

-- 15.1 Risk comparison based on delivery email and recipient match status
SELECT 
    CASE 
        WHEN P_emaildomain = R_emaildomain THEN '01: Same Domain (Low Risk)'
        WHEN R_emaildomain IS NULL OR R_emaildomain = '' THEN '02: Direct Purchase / Digital'
        ELSE '03: Different Recipient Domain (High Risk)'
    END AS shipping_recipient_type,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS fraud_transactions,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM train_transaction
GROUP BY shipping_recipient_type
ORDER BY fraud_rate_pct DESC;
