
USE AdventureWorks2022;

Select Top 500 BusinessEntityID AS EmpID,
		FirstName,
		LastName 
From Person.Person 
Order by BusinessEntityID DESC;


Select Top 500 BusinessEntityID AS EmpID
		,FirstName,
		LastName 
From Person.Person 
Order by FirstName ASC;


Select Top 10 Percent
	BusinessEntityID AS EmpID,
	FirstName,
	LastName 
From Person.Person 
Order by 1 ASC;


Select SalesOrderID,
		SubTotal 
From Sales.SalesOrderHeader 
Order by 2 Desc;


Select * From Sales.SalesOrderHeader;

--WERE Condition Clause to filter
Select [SalesOrderID],
		[SubTotal]
From Sales.SalesOrderHeader
where [CustomerID]= '29974'
Order by 2 Desc;


--
Select * From Production.Product
Where ListPrice>1000;


Select * From Production.Product
Where ListPrice>1000 Order by ListPrice ASC;

-->,>=,<,<=,=,<>,!=

Select * From Production.Product
Where ListPrice <> 1700.9 Order by ListPrice ASC;

Select * From Production.Product
Where ListPrice>=1500 and  ListPrice <> 1700.9 Order by ListPrice ASC;


Select * From Production.Product
Where ListPrice Between 3000 and  4000 Order by ListPrice ASC;


Select * From HumanResources.vEmployee;


Select * From HumanResources.vEmployee
Where FirstName = 'Chris';

--Or  / In qurey
Select * From HumanResources.vEmployee
Where FirstName In  ('Chris','David','John','Mary');


--Text Filter (Wild Card)  Like and % wild card
-- Like 'Mi%
-- Like '%Engineer%';
-- Like '%on';
-- Like'_on';
-- Like 'D[a,o]n';
-- Like 'K[a-f,h-z]n';



Select * From HumanResources.vEmployee
Where FirstName Like 'Mi%';

Select * From HumanResources.vEmployee
Where JobTitle Like '%Engineer%';


Select * From HumanResources.vEmployee
Where FirstName Like '%on';

--  one _ is single value and two __ is two sigle value
Select * From HumanResources.vEmployee
Where FirstName Like '_on';


Select * From HumanResources.vEmployee
Where FirstName Like 'D[a,o]n';

Select * From HumanResources.vEmployee
Where FirstName Like 'K[a-f,h-z]n';


Select * From HumanResources.vEmployee
Where FirstName Like '[a-z]%';

Select * From HumanResources.vEmployee
Where PhoneNumber Like '[a-z]%';


Select * 
From HumanResources.Employee
Where BirthDate >= '1988-01-01' and Gender= 'F';

Select * 
From HumanResources.Employee
Where BirthDate >= '1988-01-01' and Gender= 'F' and MaritalStatus='S';


Select * 
From HumanResources.Employee
Where BirthDate Between '1988-01-01' and '2000-12-31';

Select * 
From HumanResources.Employee
Where JobTitle ='Sales Representative' and MaritalStatus = 'S';

Select * 
From HumanResources.Employee
Where JobTitle ='Sales Representative' and  (MaritalStatus = 'S' or Gender='F');


Select * 
From HumanResources.vEmployee
Where MiddleName IS NUll;

Select * 
From HumanResources.vEmployee
Where MiddleName IS not NUll;
