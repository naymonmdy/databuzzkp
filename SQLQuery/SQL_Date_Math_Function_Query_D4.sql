--Math Function

USE AdventureWorks2022;

SELECT * From Sales.SalesPerson;
SELECT	BusinessEntityID AS SalespersonID ,
		CommissionPct,
	    SalesYTD , 
	    Bonus,
		SalesDiff = SalesLastYear - SalesYTD,
		SalesLastYear,
	    CommissionPct * SalesYTD AS CommissionYTD,
	   (CommissionPct * SalesYTD) + Bonus AS IncomeYTD
FROM Sales.SalesPerson;

--Date Function,
--Current locale Time
SELECT GETDATE(),GETUTCDATE(),SYSUTCDATETIME();


SELECT GETDATE(),
	   YEAR(GETDATE()) AS Year,
	   Month(GETDATE()) AS Month,
	   DAY(GETDATE()) AS Day;

SELECT CONCAT(YEAR(GETDATE()),'-',Month(GETDATE()),'-',1);

--First Day of the Month 
SELECT DATEFROMPARTS (YEAR(GETDATE()),Month(GETDATE()),1);

--Last Day of previous Month
SELECT DATEADD(DAY,-1, DATEFROMPARTS(YEAR(GETDATE()),Month(GETDATE()),1));

--First Day of Previous Month
SELECT DATEADD(MONTH,-1, DATEFROMPARTS(YEAR(GETDATE()),Month(GETDATE()),1));

--Last Day of Current Month
SELECT EOMONTH (GETDATE());

SELECT SalesOrderID FROM Sales.SalesOrderHeader Where YEAR(OrderDate) = '2011';

--To change date Function by using by CAST as date function
SELECT SalesOrderID,
		CAST(OrderDate AS date) OrderDate,
		Cast(ShipDate AS date) ShipDate
FROM Sales.SalesOrderHeader 
Where YEAR(OrderDate) = '2011';


---To get Date diff from DATEDIFF
SELECT SalesOrderID,
		CAST(OrderDate AS date) OrderDate,
		Cast(ShipDate AS date) ShipDate,
		DATEDIFF(DAY,OrderDate,ShipDate) AS ElaspseDay
FROM Sales.SalesOrderHeader 
Where YEAR(OrderDate) = '2011';