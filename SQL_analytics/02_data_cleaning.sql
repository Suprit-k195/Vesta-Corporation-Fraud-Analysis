-- ==============================================================================
-- 02_DATA_CLEANING.SQL: Missing Values, Bad Placeholders & Outlier Sanity Checks
-- ==============================================================================

-- 2.1 Identify missing or blank email domain placeholders
SELECT 
    COUNT(*) AS missing_purchaser_emails,
    SUM(CASE WHEN P_emaildomain IS NULL OR P_emaildomain = '' THEN 1 ELSE 0 END) AS empty_p_emails,
    SUM(CASE WHEN R_emaildomain IS NULL OR R_emaildomain = '' THEN 1 ELSE 0 END) AS empty_r_emails
FROM train_transaction;

-- 2.2 Flag invalid transaction amounts (Negative or Zero values)
SELECT 
    TransactionID, 
    TransactionAmt, 
    isFraud 
FROM train_transaction 
WHERE TransactionAmt <= 0;
