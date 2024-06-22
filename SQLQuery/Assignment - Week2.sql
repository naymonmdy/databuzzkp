--Q1.

USE AdventureWorks2022;
SELECT
  BusinessEntityID,
  VacationHours,
  SickLeaveHours,
  TotalTimeOff = VacationHours+SickLeaveHours
from HumanResources.Employee
where SalariedFlag = 0;


--Q 2
select 
DATEADD (DAY, 100, GETDATE()) as "100DayFromNow";


--Q 3
select 
DATEADD (MONTH, 6, GETDATE()) AS "6 month from now";


--Q4
select 
YESTERDAY = CAST  (DATEADD (DAY, -1, GETDATE()) AS DATE);

--Q5
select 
Name,
Color
From Production.Product
Where ISNULL (Weight,0) < 10;


--Q6
select 
Name,
ListPrice,
CASE
When ListPrice > 1000 then 'Premium'
When ListPrice >100  then 'Midrange'
ELSE 'value'
END AS "Price Category"
From Production.Product;


--Q7
Select 
BusinessEntityID,
HireDate,
SalariedFlag,
CASE
When SalariedFlag = 1 AND DATEDIFF (Year, HireDate, GETDATE()) >= 10 then 'Non-Exempt - 10+ Years'
When SalariedFlag = 1 AND DATEDIFF (Year, HireDate, GETDATE()) <10 then 'Non-Exempt - < 10 Years'
When SalariedFlag = 0 AND DATEDIFF (Year, HireDate, GETDATE()) >= 10 then 'Exempt - 10+ Years'
ELSE 'Exempt - < 10 Years'
END AS 'Employee Tenure'
From HumanResources.Employee;