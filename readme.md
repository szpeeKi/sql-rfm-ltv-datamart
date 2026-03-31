# 📊 Customer Data Mart: Analytical Segmentation (RFM & LTV)

## 🎯 The Business Problem
In the current e-commerce landscape, mass marketing campaigns are inefficient and costly. The goal of this project was to build an end-to-end analytical pipeline (using SQL) to transform raw transactional data into a **Consolidated Analytical View**.

This view provides the Growth and Marketing teams with the exact metrics needed to segment customers based on their actual purchasing behavior, leveraging the **RFM (Recency, Frequency, Monetary)** framework and calculating the **LTV (Lifetime Value)**.

## 🛠️ Architecture & Technical Solution
The transformation script was designed for high performance, modularity, and readability. To avoid complex nested subqueries, the logic was divided into **CTEs (Common Table Expressions)**, processing the data in layers until the final consolidation.

* **Language:** Standard SQL (Tested on SQLite / PostgreSQL)
* **Advanced Techniques Applied:**
  * `CTEs` for modularizing the data pipeline.
  * `Window Functions` (`ROW_NUMBER() OVER(PARTITION BY...)`) to dynamically rank dimensions (e.g., top customers by country, favorite product category).
  * Granularity handling (Avoiding revenue duplication using `COUNT(DISTINCT)`).
  * Null-safe operations using `COALESCE` to protect financial metrics and rankings.
  * Conditional logic (`CASE WHEN`) for automated churn risk classification.

## 🗂️ Data Modeling

### Source Data (Transactional)
The pipeline ingests data from four relational tables:
1. `users`: Account and demographic data.
2. `orders`: Order headers and fulfillment status.
3. `order_items`: Line-item granularity for purchased products.
4. `products`: Product catalog and categories.

> **Critical Business Rule:** Orders with `cancelled` or `refunded` statuses were strictly filtered out throughout the pipeline to prevent inflated LTV and conversion metrics.

### The Final Deliverable (Data Mart)
The query outputs a denormalized table with 1 row per customer (360º View), featuring:
- **Identification:** `user_id`, full name, account tenure (months), country.
- **Engagement (Frequency & Recency):** Total valid orders, date of the last purchase.
- **Value (Monetary):** Average Ticket and Lifetime Value (LTV).
- **Product Intelligence:** Customer's favorite category (dynamically ranked via Window Function).
- **Churn Risk Classification:** Automated flag based on recency (`Active`, `Sleeping`, `Risk of Churn`).
- **LTV Rank:** The customer's position in the revenue ranking within their respective country.

## 🚀 How to Run

1. Clone this repository.
2. Execute the `01_schema_mock.sql` file in your database (PostgreSQL/SQLite) to create the schema and inject the mock dataset (which includes edge cases like churned users, refunds, and brand-new accounts).
3. Run the main script `02_rfm_transformation.sql` to compile the CTEs and generate the final segmentation table.

---
*Project developed to showcase advanced skills in Data Engineering and Analytical SQL.*