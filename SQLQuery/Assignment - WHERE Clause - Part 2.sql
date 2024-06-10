--Assignment - WHERE Clause - Part 2

Use AdventureWorks2022;
--Qusetion  8
select * from HumanResources.vEmployeeDepartment Where StartDate Between '19900701' and '19910630';
select * from HumanResources.vEmployeeDepartment Where StartDate >= '19900701' and StartDate <= '19910630';


--Question 9
select * from  Sales.vIndividualCustomer Where LastName LIKE 'R%';


--Question 10
select * from  Sales.vIndividualCustomer Where LastName LIKE '%r';


--Question 11
SELECT * FROM Sales.vIndividualCustomer WHERE LastName IN ('Lopez', 'Martin', 'Wood') AND FirstName LIKE '[C-L]%';


--Qustition 12
SELECT * FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL;


--Qustition 13
SELECT SalesPersonID, TotalDue FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TotalDue > 70000;

