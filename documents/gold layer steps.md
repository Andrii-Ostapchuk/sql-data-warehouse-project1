Here are the practical architectural patterns to implement the Gold layer for the Olist dataset.

### 1. The "One Big Table" (OBT) Pattern

BI tools perform poorly when executing 7-way joins on the fly. The OBT pattern denormalizes your Silver star schema into a single, highly redundant, wide table for maximum read performance.

**Action:** Create a `gold.obt_sales` table.

* **Joins:** Combine `orders`, `order_items`, `products`, `customers`, `sellers`, and `reviews`.
* **Columns:** Include English category names directly next to product dimensions, and customer coordinates directly next to delivery timestamps.
* **Filter:** Exclude rows where your `is_valid_date_sequence` or `physical_dimentions_integrity` flags are `FALSE`. Do not expose bad data to the business.

### 2. Aggregated Data Marts (Subject-Oriented)

Executives do not want row-level order data; they want aggregated KPIs. Build specific aggregated tables based on business domains.

**A. Executive Sales Mart (`gold.mart_sales_monthly`)**

* **Grain:** Month, State, Product Category.
* **Metrics:**
* Gross Merchandise Value (GMV): `SUM(price)`
* Total Freight Cost: `SUM(freight_value)`
* Order Volume: `COUNT(DISTINCT order_id)`
* Average Order Value (AOV): `SUM(price + freight_value) / COUNT(DISTINCT order_id)`



**B. Logistics & SLA Performance Mart (`gold.mart_logistics_performance`)**

* **Grain:** Carrier Route (Seller State $\rightarrow$ Customer State).
* **Metrics:**
* Average Delivery Days: `AVG(delivery_date - purchase_date)`
* SLA Compliance Rate: Percentage of orders where `actual_delivery_date <= estimated_delivery_date`.
* Freight Efficiency: Average freight cost per kilogram.



**C. Seller Performance Snapshot (`gold.mart_seller_360`)**

* **Grain:** `seller_id` (1 row per seller).
* **Metrics:** Total lifetime revenue, average review score received, total items sold, and days since last sale (recency).

**D. Customer Lifetime Value (CLV) Mart (`gold.mart_customer_360`)**

* **Grain:** `customer_unique_id` (1 row per human).
* **Metrics:** First purchase date, last purchase date, total orders, total spend, and average review score given. *Note: You must use `customer_unique_id` here, not the transactional `customer_id`.*
