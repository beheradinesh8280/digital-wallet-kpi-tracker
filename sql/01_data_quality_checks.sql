-- 1. Find duplicate customer emails
SELECT 
    LOWER(email) AS email,
    COUNT(*) AS duplicate_count
FROM customers
WHERE email IS NOT NULL
GROUP BY LOWER(email)
HAVING COUNT(*) > 1;


-- 2. Find NULL customer IDs
SELECT *
FROM customers
WHERE customer_id IS NULL;


-- 3. Find invalid email formats
SELECT *
FROM customers
WHERE email IS NOT NULL
  AND email NOT LIKE '%@%.%';


-- 4. Find duplicate transaction IDs
SELECT 
    transaction_id,
    COUNT(*) AS duplicate_count
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;


-- 5. Find invalid transaction amounts
SELECT *
FROM transactions
WHERE amount IS NULL
   OR amount <= 0;


-- 6. Find transactions with invalid status
SELECT *
FROM transactions
WHERE status NOT IN ('SUCCESS', 'FAILED', 'PENDING');