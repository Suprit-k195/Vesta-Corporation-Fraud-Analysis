# E-Commerce Fraud Analytics & Detection System

> Built on a real-world dataset from **Vesta Corporation**, released through an **IEEE-CIS** research competition.

## About This Project

This project is a deep-dive SQL analysis of online transaction data, built to find patterns that help spot fraud before it happens. I used the **IEEE-CIS Fraud Detection dataset** (from Kaggle), which contains real, anonymized e-commerce transaction records — things like transaction amount, card type, device used, email domain, and whether the transaction turned out to be fraudulent.

The goal was simple: Use SQL to answer real business questions such as:
- Which product categories, card types, or devices have the highest fraud risk?
- Are there time-of-day patterns in fraud activity?
- Can we catch suspicious behavior like rapid checkouts or "card testing" (a small test charge followed by a big one)?
- How much money is actually being lost to fraud, and where?

## About the Dataset

It's real e-commerce transaction data from **Vesta Corporation**, one of the largest payment guarantee companies in the world, handling over **$18 billion** in guaranteed transactions every year. Vesta partnered with the **IEEE Computational Intelligence Society (IEEE-CIS)** to release this data publicly through a Kaggle competition, with the goal of pushing the industry toward better fraud detection.


It's split into two tables:
- **train_transaction** – core transaction details (amount, product, card info, email domains, fraud label)
- **train_identity** – device and browser/OS information linked to some of those transactions

In total, it covers **590,540 transactions**, of which about **3.5% are labeled as fraud**

## What's Inside

The analysis is broken into 16 SQL files, each focused on one area, so it's easy to follow and reuse:

| File | What It Covers |
|---|---|
| `01_data_setup.sql` | Creates the database tables |
| `02_data_cleaning.sql` | Checks for missing values and bad data |
| `03_fraud_overview.sql` | Overall fraud rate and category-level risk |
| `04_transaction_analysis.sql` | Fraud risk by transaction amount |
| `05_customer_analysis.sql` | Spending patterns and repeat risk by card |
| `06_card_analysis.sql` | Fraud rate by card network and payment type |
| `07_device_analysis.sql` | Mobile vs. desktop fraud, and shared-device checks |
| `08_email_analysis.sql` | Risky email domains and email mismatches |
| `09_time_analysis.sql` | Fraud patterns across hours of the day |
| `10_product_analysis.sql` | Financial loss by product category |
| `11_high_risk_detection.sql` | Rule-based flags for suspicious orders |
| `12_fraud_patterns.sql` | Rapid checkouts and card-testing behavior |
| `13_chargeback_loss_analysis.sql` | Estimated financial losses from fraud |
| `14_ip_geolocation_analysis.sql` | Fraud rate by operating system |
| `15_address_verification_analysis.sql` | Risk from shipping/recipient mismatches |
| `16_account_age_analysis.sql` | Fraud rate by account/customer tenure |

## Tools Used

- **MySQLWorkbench** for writing and running all queries
- Core SQL techniques: window functions, CTEs, joins, CASE-based bucketing, and aggregate scoring

## A Quick Note

The dataset doesn't include real customer IDs, so `card1` is used as a stand-in for "customer" in a couple of the files. It's a common workaround with this dataset, but it's not a perfect one — just something worth knowing if you dig into the results.
