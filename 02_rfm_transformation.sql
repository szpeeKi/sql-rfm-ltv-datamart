WITH account_info AS (
    SELECT 
        user_id,
        country,
        CONCAT(first_name, ' ', last_name) AS full_name,
        (((strftime('%Y', 'now')) - strftime('%Y', created_at)) * 12) - (strftime('%m', created_at) - strftime('%m', 'now')) AS account_time
    FROM users
),

user_metrics AS (
    SELECT 
        t1.user_id,
        COUNT(DISTINCT(t1.order_id)) AS total_orders,
        MAX(t1.order_date) AS last_order,
        SUM(t2.unit_price * t2.quantity) AS total_sum,
        SUM(t2.unit_price * t2.quantity)/COUNT(DISTINCT(t1.order_id)) AS average_ticket
    FROM orders AS t1
    INNER JOIN order_items AS t2
    ON t1.order_id = t2.order_id
    WHERE status = 'completed'
    GROUP BY t1.user_id
),

ranked_categories AS(
    SELECT 
        t1.user_id,
        t3.category,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY SUM(t2.quantity) DESC) AS category_rank
    FROM orders AS t1
    INNER JOIN order_items AS t2
        ON t1.order_id = t2.order_id
    INNER JOIN products AS t3
        ON t2.product_id = t3.product_id
    WHERE status = 'completed'
    GROUP BY t1.user_id,t3.category
)

SELECT 
    t1.user_id,
    t1.full_name,
    t1.account_time,
    t1.country,
    COALESCE(t2.total_orders, 0) AS total_orders,
    COALESCE(t2.total_sum, 0) AS lifetime_value,
    COALESCE(t2.average_ticket, 0) AS average_ticket,
    t2.last_order,
    t3.category AS favorite_category,
    CASE 
        WHEN (julianday('now') - julianday(t2.last_order)) < 30 THEN 'Active'
        WHEN (julianday('now') - julianday(t2.last_order)) BETWEEN 30 AND 90 THEN 'Sleeping'
        WHEN (julianday('now') - julianday(t2.last_order)) > 90 THEN 'Risk of churn'
        ELSE 'New Customer'
    END AS customer_segment,
    ROW_NUMBER() OVER(PARTITION BY t1.country ORDER BY COALESCE(t2.total_sum,0) DESC) AS ltv_country_rank
FROM account_info AS t1
LEFT JOIN user_metrics AS t2
ON t1.user_id = t2.user_id
LEFT JOIN ranked_categories AS t3
ON t1.user_id = t3.user_id AND t3.category_rank = 1