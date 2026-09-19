-- Overall transaction KPIs

SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(amount) AS total_transaction_amount,
    AVG(amount) AS average_transaction_amount
FROM transactions;
-- Transaction success rate

SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'SUCCESS' THEN 1 ELSE 0 END) AS successful_transactions,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'SUCCESS' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS success_rate
FROM transactions;