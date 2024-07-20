use AdventureWorks2022;

--Lead and Leaf
select 
SubTotal,
Lead(SubTotal,1) over(order by Subtotal desc) 
from Sales.SalesOrderHeader;

select 
Year(OrderDate) as "Year", 
sum(SubTotal) as Sales
from Sales.SalesOrderHeader
group by year(OrderDate)
order by year(OrderDate) asc;



select 
Year(OrderDate) as "Year", 
sum(SubTotal) as "Sales",
lead(sum(Subtotal),1) over(order by sum(Subtotal) desc) as "Last Year"
from Sales.SalesOrderHeader
group by year(OrderDate)
order by year(OrderDate) asc;

-----------------------------------------------------------------------------------
--REVISION

--Basic
select * from Production.Product;

--Row
select top 5 * from Production.Product;

--Column
select name,ListPrice from Production.Product;

--Filter (where /having)
--wildcard in / between /and /or

select * from Production.Product
where ListPrice !=0;


select * from Production.Product
where ListPrice >100;

select * from Production.Product
where name like '%race%';

select * from Production.Product
where ListPrice between 100 and 200;

select * from Production.Product
where name in ('bearing ball','Fork End');


Select *
from Production.Product
where productID in(
select ProductID from 
Sales.SalesOrderDetail
where OrderQty >5);


---Aggregation
select 
sum(subtotal)
from Sales.SalesOrderHeader;

select 
max(subtotal)
from Sales.SalesOrderHeader;

select 
OrderDate,
sum(subtotal) as 'Sales'
from Sales.SalesOrderHeader
group by OrderDate
order by OrderDate asc;

select 
OrderDate,
sum(subtotal) as 'Sales'
from Sales.SalesOrderHeader
group by OrderDate
having sum(subtotal) >500000
order by OrderDate asc;

--Window Function
--Over(),partition by()
--Rank ,Dense_Rank,Row_Number()


select
SalesOrderID,
orderDate,
SubTotal
from Sales.SalesOrderHeader;


select
SalesOrderID,
orderDate,
Sum(SubTotal) over()
from Sales.SalesOrderHeader;

select
SalesOrderID,
orderDate,
Subtotal,
avg(SubTotal) over()
from Sales.SalesOrderHeader;


select
SalesOrderID,
orderDate,
Subtotal,
sum(SubTotal) over(partition by SalesOrderID)
from Sales.SalesOrderHeader;

select
SalesOrderID,
orderDate,
Subtotal,
sum(SubTotal) over(partition by customerID)
from Sales.SalesOrderHeader;

--Rank
select
SalesOrderID,
orderDate,
Subtotal,
sum(SubTotal) over(partition by customerID),
rank() over(order by subtotal desc) as 'Sales Rank'
from Sales.SalesOrderHeader
order by SubTotal desc;

select
SalesOrderID,
orderDate,
Subtotal,
sum(SubTotal) over(partition by customerID),
rank() over(order by subtotal desc) as 'Sales Rank',
rank() over(partition by OrderDate order by subtotal desc) as 'Sales Rank'
from Sales.SalesOrderHeader
order by OrderDate desc;

---Sub Query, CTE

select * from
(select * from HumanResources.Employee) a;

select * from(
select
SalesOrderID,
orderDate,
Subtotal,
sum(SubTotal) over(partition by customerID),
rank() over(order by subtotal desc) as 'Sales Rank',
rank() over(partition by OrderDate order by subtotal desc) as 'Sales Rank'
from Sales.SalesOrderHeader) a
where a.[Sales Rank]=1;

select * from (select OrderDate,Subtotal,DENSE_RANK() over(partition by OrderDate order by Subtotal desc) as 'Sales Rank'from sales.SalesOrderHeader)a where a.[Sales Rank] =1;---Programming SQL--alter procedure yearly_sales @year 