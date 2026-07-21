WITH sales AS (
    SELECT 
        sales_id,
        product_sk,
        customer_sk,
        payment_method,
        {{multiply('quantity', 'unit_price')}} AS calculated_gross_amount
    FROM {{ ref('bronze_sales') }}
),
products AS (
    SELECT 
        product_sk,
        category
    FROM {{ ref('bronze_product') }}
),
customers AS (
    SELECT 
        customer_sk,
        gender
    FROM {{ ref('bronze_customer') }}
),
joined_sales AS (
    SELECT 
        sales_id,
        calculated_gross_amount,
        payment_method,
        category,
        gender
    FROM sales
    JOIN products ON sales.product_sk = products.product_sk
    JOIN customers ON sales.customer_sk = customers.customer_sk
)
SELECT 
    category,
    gender,
    SUM(calculated_gross_amount) AS total_sales
FROM joined_sales
GROUP BY 
    category, 
    gender
ORDER BY 
    total_sales DESC