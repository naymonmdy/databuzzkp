----- Advance Functions 

---- 1. Over()

----- 2. Partition by () / Group by 

----- partition by () over()

--- Group by Having 

--- filter 
---- where / having ???

--- where >>>> row by row >>>>> for loop 

--- having >>>> after group by >>>> aggergation 

---- Rank , Dense_Rank , Row_number 

---- Sub Query , CTE (7.6.2024)

---- Sub Query 

select * from 
Sales.SalesOrderHeader --- table a 

---- Sub Query Option 1 
select * from 
(
select 
OrderDate,
CustomerID,
SubTotal 
from Sales.SalesOrderHeader) a


select * from 
(
select  * from 
students
where class_id is not null) a
where a.student_name = 'Mg Mg'


select * from 
(
select 
OrderDate,
CustomerID,
SubTotal ,
DENSE_RANK() over(partition by OrderDate Order by SubTotal desc) as 'Sales Rank'
from Sales.SalesOrderHeader) a
where a.[Sales Rank] between 1 and 5 



select 
* from Production.Product
where ListPrice > 438


---- Sub Query Option 2 
select 
* from Production.Product
where ListPrice > (select avg(ListPrice) from Production.Product)

select 
avg(ListPrice)
from Production.Product


select * from
Sales.SalesOrderHeader

---- onlineOrderflag >>> 0 >>>> store 
---- onlineOrderflag >>> 1 >>>> online 


---- online က နေ ဝယ်တဲ့ products နာမည်တွေ ကို သိချင်တာ 


---- Sub Query 


select 
* from 
Sales.SalesOrderHeader



select 
* from 
Sales.SalesOrderDetail


select * from 
Production.Product


select 
p.Name as 'Product',
soh.OnlineOrderFlag as 'Order Status'
from Sales.SalesOrderHeader soh 
join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
join Production.Product p on p.ProductID = sod.ProductID
where soh.OnlineOrderFlag = 1


---- Sub Query Option 3 Join 

select 
p.Name as 'Product'
from sales.SalesOrderDetail sod 
join (select SalesOrderID from Sales.SalesOrderHeader where OnlineOrderFlag = 1) soh
on soh.SalesOrderID = sod.SalesOrderID
join Production.Product p on p.ProductID = sod.ProductID

---- Sub Query Option 3 

select * from 
Sales.SalesOrderDetail
where SalesOrderID in (select SalesOrderID from Sales.SalesOrderHeader where OnlineOrderFlag = 1) --- join 1 


---- Sub Query + in (filter) 

select * from 
Production.Product   ---- join 3 
where ProductID in (
select ProductID from  ---- join 2 
Sales.SalesOrderDetail
where SalesOrderID in ( select SalesOrderID from Sales.SalesOrderHeader where OnlineOrderFlag = 1)) --- join 1 



----- CTE (Common Table Expression)


---- Sub Query 

----- Total Vacation Hours > 50 
----- Hire Date 2009 နောက်ပိုင်း 

select * from (
select * from (
select * from (
select 
JobTitle,
HireDate,
sum(VacationHours) as 'Total Vacation Hours'
from 
HumanResources.Employee
group by JobTitle,HireDate) a 
where a.[Total Vacation Hours] > 50 ) b
where year( b.HireDate) > 2009) c 


---- CTE 

with t1 as (
select 
JobTitle,
HireDate,
sum(VacationHours) as 'Total Vacation Hours'
from 
HumanResources.Employee
group by JobTitle,HireDate),

t2 as ( ---- vacation hours > 50
select * from t1
where [Total Vacation Hours] > 50),


t3 as (
select * from t2
where year(HireDate) > 2009)

select * from t1

---- table 
---- temp table 

select 
JobTitle,
HireDate,
sum(VacationHours) as 'Total Vacation Hours'
into #tmp_t1
from 
HumanResources.Employee
group by JobTitle,HireDate


select * 
into #tmp_t2
from 
#tmp_t1
where [Total Vacation Hours] > 50 


select * 
into #tmp_t3
from #tmp_t2
where year(HireDate) > 2009


select * from 
#tmp_t3

---- Data Analysis >>>> SQL >>>> Query >>> Report 

---- Data Analysis >>>> Excel  >>> Report 

---- Data Analysis >>>> SQL (ETL) ---- Data Engineering , Cloud System (AWS,Azure,GCP) , Python 

----- Data Analytics Engineer (Data WareHouseing) Date Engineering + Data Analysis 

---- Programming SQL 

---- ETL (Extract , Transform , Load)

---- Table 

---- copy one table to another table 

---- table copy 

select *
into demo_table
from 
Sales.SalesOrderHeader


select * from 
demo_table


---- Column Add 

alter table demo_table 
add Col1 int


---- table delete 

---- drop table 
---- delete table 
---- truncate table 


select * from 
demo_table

---- drop the table
drop table demo_table

----- delete the table >>>> where condition 
delete  from demo_table 
where year(OrderDate) = 2011

---- delete the table 
truncate table demo_table 


--- interviews >>>>> truncate , delete ?????
---- interviews >>> where/having 
----- interviews >>>> left join , right join 

create table students (
student_id int
student_name varchar(50),
class_id int)

---- view table 
create view v_t1 as (
select 
OrderDate,
CustomerID,
SubTotal,
TotalDue
from  Sales.SalesOrderHeader)


select * from 
v_t1

---- Store Procedure 
---- Variable 
---- if 

select *
into demo_table
from 
Sales.SalesOrderHeader

select * 
from demo_table

begin transaction 
drop table demo_table


begin transaction 
delete from demo_table 
where Year(OrderDate) = 2011

rollback
