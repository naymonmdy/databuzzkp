/*
	Primary Key and Foreign Key
*/

Use AdventureWorks2022;

select * from Sales.SalesOrderDetail;
--transition table
--Product ID is foreign key (fk)



Select * from Production.Product;
--Product ID is primary key (pk)



--Many to Many ==> fk to fk
--one to Many ==> fk to pk
--one to one ==> pk to pk


--Join
--Where and Having
--SUB Query
--CTB


--1.INNER JOIN
select * from Sales.SalesOrderDetail a
join Production.Product b on a.ProductID = b.ProductID;

select a.SalesOrderID,
a.OrderQty,
b.Name as 'Product Name',
b.Listprice as 'Selling price'
From
Sales.SalesOrderDetail a
join Production.Product b on a.ProductID = b.ProductID;



Select  * from 
Sales.SalesOrderHeader;

Select  * from 
Sales.SalesOrderDetail;


--Left Join/Left Outer Join and all row return main from left table behind FROM
select 
a.SalesOrderID,
a.OrderQty,
b.Name as 'Product Name',
b.ListPrice as 'Selling Price'
From
Production.Product b
left join Sales.SalesOrderDetail a on a.ProductID = b.ProductID;--Second table


--right Join/Right Outer Join and all row return main from right table 
select 
a.SalesOrderID,
a.OrderQty,
b.Name as 'Product Name',
b.ListPrice as 'Selling Price'
From
Production.Product b
right join Sales.SalesOrderDetail a on a.ProductID = b.ProductID;


--table create

create table students(
student_id INT ,
student_name varchar(50),
class_id int
)

select * from students;


insert into students (student_id,student_name,class_id)
values (100,'Mg Mg',1001),
 (200,'Kyaw Kyaw',1001),
 (300,'Hla Hla',1002),
 (400,'Mya Mya',null)


create table class(
student_id INT ,
class_name varchar(50)
)


select * from students;
select * from class;

insert into class (student_id,class_name)
values (100,'English'),
(200,'Mathmetics'),
(300,'Hist'),
(200,'IT'),
(null,'support');

---Inner Jion

Select * from
students s
join class c on s.student_id=c.student_id; 



Select * from
students s
left join class c on s.student_id=c.student_id;

Select * from
students s
right join class c on s.student_id=c.student_id;

--Full outer join
select
s.student_name,
c.class_name
from students s
full outer join class c on s.student_id=c.student_id;

--Cross join // not mainly use
select
s.student_name,
c.class_name
from students s
cross join class c;


--Aggregation Function 
--Sum
--agv
--count
--distinct
--max
--min

select * from Sales.SalesOrderHeader;

Select sum(Subtotal) as total
from 
Sales.SalesOrderHeader;


Select max(Subtotal) as max_value
from 
Sales.SalesOrderHeader;


Select min(Subtotal) as min_value
from 
Sales.SalesOrderHeader;


Select avg(Subtotal) as avg_value
from 
Sales.SalesOrderHeader;


Select count(*) 
from 
Sales.SalesOrderHeader;



Select count(SalesOrderID)
from 
Sales.SalesOrderHeader;



--aggregation function depend on other column need group by

Select 
OrderDate,
sum(SubTotal)
from 
Sales.SalesOrderHeader
group by OrderDate
;

Select 
OrderDate,
ShipDate,
sum(SubTotal)
from 
Sales.SalesOrderHeader
group by OrderDate,ShipDate
;

Select 
OrderDate,
ShipDate,
sum(SubTotal)
from 
Sales.SalesOrderHeader
group by OrderDate,ShipDate
order by OrderDate asc
;

--HAVING CLAUSE and WHERT CLAUSE


--Where filter by row by row
Select 
OrderDate,
SubTotal
from 
Sales.SalesOrderHeader
Where SubTotal > 100000;

---100000 After group by Aggregation with Having
Select 
OrderDate,
sum(SubTotal) as SumDate
from 
Sales.SalesOrderHeader
group by OrderDate
having sum(SubTotal) > 100000;


Select 
Name as 'Product Name',
ListPrice
from
Production.Product
group by Name
having ListPrice > avg(ListPrice)
 ;



 Select 
Name as 'Product Name',
ListPrice
from
Production.Product
where ListPrice > (select avg(ListPrice) from Production.Product);
 ;