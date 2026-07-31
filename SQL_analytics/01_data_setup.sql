-- ==============================================================================
-- 01_DATA_SETUP.SQL: Schema Creation & Core Table Definitions
-- ==============================================================================

-- 1.1 Create Main Transaction Table Schema
CREATE TABLE IF NOT EXISTS train_transaction (
    TransactionID INT PRIMARY KEY,
    isFraud INT,
    TransactionDT INT,
    TransactionAmt DECIMAL(10, 2),
    ProductCD VARCHAR(10),
    card1 INT, 
    card2 INT, 
    card3 INT, 
    card4 VARCHAR(20), 
    card5 INT, 
    card6 VARCHAR(20),
    P_emaildomain VARCHAR(50),
    R_emaildomain VARCHAR(50)
);

-- 1.2 Create Main Identity Table Schema
CREATE TABLE IF NOT EXISTS train_identity (
    TransactionID INT PRIMARY KEY,
    DeviceType VARCHAR(20),
    DeviceInfo VARCHAR(50),
    id_30 VARCHAR(50),
    FOREIGN KEY (TransactionID) REFERENCES train_transaction(TransactionID)
);
