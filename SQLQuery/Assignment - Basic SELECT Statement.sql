--Question 1
USE AdventureWorks2022;
SELECT NationalIDNumber FROM HumanResources.Employee;

--Question 2
SELECT NationalIDNumber,JobTitle FROM HumanResources.Employee;

--Question 3
SELECT TOP 20 percent
NationalIDNumber,JobTitle,BirthDate FROM HumanResources.Employee;

--Question 4
SELECT TOP 500 
NationalIDNumber AS "SSN",JobTitle AS "Job Title",BirthDate FROM HumanResources.Employee;

--Question 5
SELECT * FROM  Sales.SalesOrderHeader;

--Question 6
SELECT TOP 20 percent * FROM Sales.Customer;

--Question 7
SELECT Name AS "Product’s Name"
FROM Production.vProductAndDescription;

--Question 8
SELECT TOP 800 * FROM HumanResources.Department;

--Question 9
SELECT  * FROM Production.BillOfMaterials;

--Question 10
SELECT TOP 1500 * FROM Sales.vPersonDemographics;