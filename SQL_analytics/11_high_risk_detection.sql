-- ==============================================================================
-- 11_HIGH_RISK_DETECTION.SQL: Multi-Attribute Rule Engine Trigger
-- ==============================================================================

-- 11.1 Flag high-risk orders combining amount, payment type, and anonymous email
SELECT
    t.TransactionID,
    t.card1 AS customer_id,
    t.TransactionAmt,
    t.ProductCD,
    t.P_emaildomain,
    t.card6 AS payment_type,
    t.isFraud
FROM train_transaction t
WHERE t.TransactionAmt > 300
  AND t.card6 = 'credit'
  AND t.P_emaildomain IN ('mail.com', 'protonmail.com', 'anonymous.com')
ORDER BY t.TransactionAmt DESC;
