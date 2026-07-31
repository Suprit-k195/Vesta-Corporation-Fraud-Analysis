-- ==============================================================================
-- 12_FRAUD_PATTERNS.SQL: Rapid Checkout Velocity & Card Testing Patterns
-- ==============================================================================

-- 12.1 Rapid checkout velocity analysis (< 60s gap between orders)
WITH transaction_lags AS (
    SELECT
        t.TransactionID,
        t.card1 AS customer_id,
        t.TransactionDT,
        t.TransactionAmt,
        t.isFraud,
        LAG(t.TransactionDT) OVER (PARTITION BY t.card1 ORDER BY t.TransactionDT ASC) AS prev_transaction_dt
    FROM train_transaction t
)
SELECT
    TransactionID,
    customer_id,
    TransactionAmt,
    (TransactionDT - prev_transaction_dt) AS seconds_since_last_txn,
    isFraud
FROM transaction_lags
WHERE prev_transaction_dt IS NOT NULL
  AND (TransactionDT - prev_transaction_dt) <= 60
ORDER BY seconds_since_last_txn ASC;

-- 12.2 Card testing signature: Small authorization (<$10) followed by high-value order
WITH ordered_txns AS (
    SELECT 
        t.TransactionID,
        t.card1 AS customer_id,
        t.TransactionAmt,
        t.isFraud,
        LAG(t.TransactionAmt) OVER (PARTITION BY t.card1 ORDER BY t.TransactionDT ASC) AS prev_amt
    FROM train_transaction t
)
SELECT 
    TransactionID,
    customer_id,
    prev_amt AS test_transaction_amt,
    TransactionAmt AS target_transaction_amt,
    isFraud
FROM ordered_txns
WHERE prev_amt < 10.00 
  AND TransactionAmt > 200.00;
