--- 1. How many pubs are located in each country?

SELECT * FROM sales;
SELECT * FROM beverages;
SELECT * FROM pubs;



USE pricing;
SELECT country, COUNT(*) AS number_of_pubs
FROM pubs
GROUP BY country;


---2. What is the total sales amount for each pub, including the beverage price and quantity sold?
SELECT s.pub_id, p.pub_name,
SUM(b.price_per_unit * s.quantity) AS total_sales_amount
FROM sales s
JOIN beverages b ON s.beverage_id = b.beverage_id
JOIN pubs p ON s.pub_id = p.pub_id
GROUP BY s.pub_id, p.pub_name;


--3.Which pub has the highest average rating?

SELECT TOP 1
r.pub_id, p.pub_name, AVG(r.rating) AS average_rating
FROM ratings r
JOIN pubs p ON r.pub_id = p.pub_id
GROUP BY r.pub_id, p.pub_name
ORDER BY average_rating DESC;

--4. What are the top 5 beverages by sales quantity across all pubs?
SELECT TOP 5 
b.beverage_name, 
SUM(s.quantity) AS total_quantity_sold
FROM sales s
JOIN beverages b 
ON s.beverage_id = b.beverage_id
GROUP BY b.beverage_name
ORDER BY total_quantity_sold DESC;

--5. How many sales transactions occurred on each date?
SELECT transaction_date, 
COUNT(*) AS number_of_transactions
FROM sales
GROUP BY transaction_date
ORDER BY transaction_date;


--6.Find the name of someone that had cocktails and which pub they had it in.
SELECT r.customer_name, p.pub_name
FROM sales s
JOIN beverages b ON s.beverage_id = b.beverage_id
JOIN pubs p ON s.pub_id = p.pub_id
JOIN ratings r ON s.pub_id = r.pub_id
WHERE b.category = 'Cocktail';


--7. What is the average price per unit for each category of beverages, excluding the category 'Spirit'?
SELECT category,
AVG(price_per_unit) AS average_price_per_unit
FROM beverages
WHERE category != 'Spirit'
GROUP BY category;

--8. Which pubs have a rating higher than the average rating of all pubs?
DECLARE @over_all_rating DECIMAL(10,2);
SET @over_all_rating = (SELECT avg(rating) FROM ratings);

SELECT 
    p.pub_id, 
    p.pub_name, 
    AVG(r.rating) AS pub_average_rating,
    @over_all_rating AS over_all_rating
FROM ratings r
JOIN pubs p ON r.pub_id = p.pub_id
GROUP BY p.pub_id, p.pub_name
HAVING AVG(r.rating) > @over_all_rating;

---9. What is the running total of sales amount for each pub, ordered by the transaction date?
SELECT 
    s.pub_id, 
    p.pub_name,
    s.transaction_date,
	b.beverage_name,
    SUM(b.price_per_unit * s.quantity) OVER (PARTITION BY s.pub_id ORDER BY s.transaction_date) AS runningtotal
FROM sales s
JOIN beverages b ON s.beverage_id = b.beverage_id
JOIN pubs p ON s.pub_id = p.pub_id
ORDER BY s.pub_id, s.transaction_date;

---10. For each country, what is the average price per unit of beverages in each category, // and what is the overall average price per unit of beverages across all categories?

SELECT 
    p.country,
    b.category,
    AVG(b.price_per_unit) AS average_price_per_unit,
    (SELECT AVG(price_per_unit) FROM beverages) AS overall_average_price_per_unit
FROM 
    beverages b
JOIN sales s ON b.beverage_id = s.beverage_id
JOIN pubs p ON s.pub_id = p.pub_id
GROUP BY p.country, b.category
ORDER BY p.country, b.category;





-- 11. For each pub, what is the percentage contribution of each category of beverages to the total sales amount, and what is the pub's overall sales amount?

SELECT 
    p.pub_id,
    p.pub_name,
    b.category,
    SUM(s.quantity * b.price_per_unit) AS total_sales_amount_for_each_category,
	(
		SUM(s.quantity * b.price_per_unit) / 
        SUM(SUM(s.quantity * b.price_per_unit)) OVER (PARTITION BY p.pub_id)
	 ) * 100 AS category_contribution_percentage,
	 SUM(SUM(s.quantity * b.price_per_unit)) OVER (PARTITION BY p.pub_id) AS each_pub_total,
	 SUM(SUM(s.quantity * b.price_per_unit)) OVER() AS all_pub_total
FROM sales s
JOIN beverages b ON s.beverage_id = b.beverage_id
JOIN pubs p ON s.pub_id = p.pub_id
GROUP BY p.pub_id, p.pub_name, b.category
ORDER BY p.pub_id, b.category;
