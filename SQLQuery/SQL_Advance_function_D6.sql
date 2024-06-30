use AdventureWorks2022;


--Advance Function


--Data Analyst
--SQL >>>> Windows Function
--SQL  >>> Sub Query
--SQL >>> CTE


--Data Egineering , Database Administrator
--SQL >>> Variable ,Store Procudure



--SQL Advance (Windows Function)

Select * from 
Sales.SalesOrderHeader;

Select 
OrderDate,
ShipDate,
sum(Subtotal) as 'Total Sales'
From Sales.SalesOrderHeader
group by OrderDate,ShipDate;

--over() no need group by function
Select 
OrderDate,
ShipDate,
sum(Subtotal) over() 'Total all Sales'
From Sales.SalesOrderHeader;

Select 
OrderDate,
ShipDate,
avg(Subtotal) over() 'Total averages'
From Sales.SalesOrderHeader;

Select 
sum(Subtotal)
From Sales.SalesOrderHeader;

Select 
OrderDate,
ShipDate,
Subtotal,
sum(Subtotal) over() 'Total all Sales',
Subtotal/sum(Subtotal) over() as 'Sale Percentage',
avg(Subtotal) over() 'Total averages'
From Sales.SalesOrderHeader;


Select * from Production.Product;

Select * from Sales.SalesOrderDetail;


select 
a.SalesOrderID,
a.OrderQty,
b.Name as 'Product Name',
b.ListPrice as 'Selling Price'
From
Production.Product b
join Sales.SalesOrderDetail a on a.ProductID = b.ProductID;



Select 
p.Name 'Product Name',
S.OrderQty
From Production.Product P
Inner Join Sales.SalesOrderDetail S
On p.ProductID=s.ProductID



Select 
p.Name 'Product Name',
S.OrderQty,
avg(S.OrderQty) over() 'All average Qty',
s.OrderQty/avg(S.OrderQty) over() 'All average Qty'
From Production.Product P
Inner Join Sales.SalesOrderDetail S
On p.ProductID=s.ProductID


Select * from
Sales.SalesOrderHeader;



SELECT 
    customerID,
    Subtotal,
    Subtotal / SUM(Subtotal) OVER () AS 'Sale Percentage'
FROM 
    Sales.SalesOrderHeader;


--Partition By

Select * from
Sales.SalesOrderHeader;

Select 
OrderDate,
sum(Subtotal) over(partition by OrderDate) as 'Partition per day'
From Sales.SalesOrderHeader;


--Slaes Percentage by Custemer level per day (ID)

Select
OrderDate,
CustomerID,
Subtotal as 'Sales',
sum(Subtotal) over (partition by OrderDate) as 'Sales Per Day',
subtotal/ sum(Subtotal) over (partition by OrderDate) as 'Sales Percentage by Custormer By ID' 
from Sales.SalesOrderHeader
order by OrderDate asc;



Select
OrderDate,
CustomerID,
Subtotal as 'Sales',
sum(Subtotal) over (partition by OrderDate) as 'Sales Per Day',
Subtotal/ sum(Subtotal) over (partition by OrderDate) as 'Sales Percentage by Custormer By ID' 
from Sales.SalesOrderHeader
order by subtotal/ sum(Subtotal) over (partition by OrderDate) desc;




Select * from
Production.Product;

Select * from
Sales.SalesOrderHeader;

Select * from
Sales.SalesOrderDetail;



Select 
soh.OrderDate,
p.Name as 'Product Name',
sod.OrderQty,
sum (sod.OrderQty) over (partition by soh.OrderDate)
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod on soh.SalesOrderID=sod.SalesOrderId
join Production.Product p on p.ProductID = sod.ProductID


--Window Functions
--Over
--Partition by
--RANK, ROW Number ,DENSE RANK

Select * from Production.Product;

select Top 5
Name as 'Product Name',
ListPrice from Production.Product
order by ListPrice desc;


Select 
Name,
ListPrice,
rank() over(order by Listprice desc) as 'Rank'
from Production.Product;

Select 
Name,
ListPrice,
rank() over(order by Listprice desc) as 'Rank',
ROW_NUMBER() over(order by Listprice desc) as 'Row Nubmer Rank'
from Production.Product;


Select 
Name,
ListPrice,
rank() over(order by Listprice desc) as 'Rank',
ROW_NUMBER() over(order by Listprice desc) as 'Row Nubmer Rank',
DENSE_RANK() over(order by Listprice desc) as 'Dense_Rank'
from Production.Product;



Select * from(
Select 
OrderDate,
CustomerID,
SubTotal as 'Sales',
DENSE_RANK() over(order by Subtotal desc) as 'Sales Rank'
from Sales.SalesOrderHeader ) a 
where a.[Sales Rank] between 1 and 5;