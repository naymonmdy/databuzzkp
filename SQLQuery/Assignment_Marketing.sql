--Q1. How many transactions were completed during each marketing campaign?
USE marketing;
SELECT 
    mc.campaign_id,
    mc.campaign_name,
    COUNT(t.transaction_id) AS transactions_count
FROM 
    marketing_campaigns mc
LEFT JOIN 
    transactions t
ON 
    mc.product_id = t.product_id
WHERE
    t.purchase_date BETWEEN mc.start_date AND mc.end_date
GROUP BY 
    mc.campaign_id, mc.campaign_name;

--2. Which product had the highest sales quantity? 
SELECT TOP 1
    sc.product_id, 
    sc.product_name, 
    SUM(t.quantity) AS total_quantity
FROM 
    sustainable_clothing sc
JOIN 
    transactions t
ON 
    sc.product_id = t.product_id
GROUP BY 
    sc.product_id, sc.product_name
ORDER BY 
    total_quantity DESC;

--3. What is the total revenue generated from each marketing campaign?
SELECT  
    mc.campaign_id,
    mc.campaign_name,
    SUM(t.quantity * sc.price) AS total_revenue
FROM 
    marketing_campaigns mc
JOIN 
    transactions t
ON 
    mc.product_id = t.product_id
JOIN 
    sustainable_clothing sc
ON 
    t.product_id = sc.product_id
WHERE 
    t.purchase_date BETWEEN mc.start_date AND mc.end_date
GROUP BY 
    mc.campaign_id, mc.campaign_name
ORDER BY 
	total_revenue DESC;

--4. What is the top-selling product category based on the total revenue generated?
SELECT TOP 1
    sc.category,
    SUM(t.quantity * sc.price) AS total_revenue
FROM 
    transactions t
JOIN 
    sustainable_clothing sc
ON 
    t.product_id = sc.product_id
GROUP BY 
    sc.category
ORDER BY 
    total_revenue DESC;

--5. Which products had a higher quantity sold compared to the average quantity sold?

DECLARE @avg_quantity INT;

SET @avg_quantity = (
    SELECT AVG(quantity) 
    FROM transactions
);

SELECT
    sc.product_id,
    sc.product_name,
    SUM(t.quantity) AS total_quantity,
    @avg_quantity AS avg_quantity
FROM
    sustainable_clothing sc
JOIN
    transactions t
ON
    sc.product_id = t.product_id
GROUP BY
    sc.product_id, sc.product_name
HAVING
    SUM(t.quantity) > @avg_quantity
ORDER BY
    total_quantity DESC;
--6. What is the average revenue generated per day during the marketing campaigns?

WITH CampaignDates AS (
    SELECT 
        c.start_date, 
        c.end_date
    FROM marketing_campaigns c
    GROUP BY c.start_date, c.end_date
),
DailyRevenue AS (
    SELECT
        t.purchase_date,
        SUM(s.price * t.quantity) AS revenue
    FROM transactions t
    JOIN sustainable_clothing s ON t.product_id = s.product_id
    JOIN CampaignDates cd ON t.purchase_date BETWEEN cd.start_date AND cd.end_date
    GROUP BY t.purchase_date
)
SELECT 
    AVG(revenue) AS avg_revenue_per_day
FROM DailyRevenue;

--7. What is the percentage contribution of each product to the total revenue?
DECLARE @total_revenue DECIMAL(12, 2);

SELECT @total_revenue = SUM(t.quantity * sc.price)
FROM transactions t
JOIN sustainable_clothing sc ON t.product_id = sc.product_id;

SELECT
    sc.product_id,
    sc.product_name,
    SUM(t.quantity * sc.price) AS product_revenue,
    @total_revenue AS total_revenue,
    100 * SUM(t.quantity * sc.price) / @total_revenue AS percentage_contribution
FROM
    sustainable_clothing sc
JOIN
    transactions t ON sc.product_id = t.product_id
GROUP BY
    sc.product_id, sc.product_name
ORDER BY
    product_revenue DESC;

 --8. Compare the average quantity sold during marketing campaigns to outside the marketing campaigns

SELECT
    AVG(
	CASE WHEN c.product_id IS NOT NULL 
	THEN t.quantity 
	ELSE NULL END) AS avg_quantity_during_campaigns,
    AVG(
	CASE WHEN c.product_id IS NULL 
	THEN t.quantity 
	ELSE NULL END) AS avg_quantity_outside_campaigns
FROM transactions t
LEFT JOIN marketing_campaigns c ON t.product_id = c.product_id
AND t.purchase_date BETWEEN c.start_date AND c.end_date;


 --9. Compare the revenue generated by products inside the marketing campaigns to outside the campaigns
 SELECT
    SUM(
	CASE 
	WHEN t.purchase_date BETWEEN c.start_date AND c.end_date 
	THEN s.price * t.quantity 
	ELSE 0 END) AS revenue_during_campaigns,
    SUM(
	CASE WHEN t.purchase_date NOT BETWEEN c.start_date AND c.end_date OR c.product_id IS NULL 
	THEN s.price * t.quantity 
	ELSE 0 END) AS revenue_outside_campaigns
FROM transactions t
JOIN sustainable_clothing s ON t.product_id = s.product_id
LEFT JOIN marketing_campaigns c ON s.product_id = c.product_id;

--10. Rank the products by their average daily quantity sold

SELECT 
    s.product_id,
    s.product_name,
    AVG(t.quantity) AS avg_daily_quantity,
    DENSE_RANK() OVER (ORDER BY AVG(t.quantity) DESC) AS rank
FROM transactions t
JOIN sustainable_clothing s ON t.product_id = s.product_id
GROUP BY s.product_id, s.product_name;