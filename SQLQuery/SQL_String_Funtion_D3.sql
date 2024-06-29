SELECT * From Person.Person;



SELECT  FirstName,MiddleName,LastName From Person.Person;

--Concatinate Column ==>USE COALESCE FUNCTION for NULL column
SELECT  FirstName,
		MiddleName,
		LastName,
		TRIM(FirstName +' '+COALESCE(MiddleName,' ')+LastName )AS FullName
From Person.Person;

SELECT  FirstName,
		MiddleName,
		LastName,
		TRIM(CONCAT(FirstName,' ',MiddleName,' ',LastName)) From Person.Person;



SELECT * FROM Sales.SalesOrderHeader;

SELECT BillToAddressID,
	   ShipToAddressID,
	   NULLIF(BillToAddressID,ShipToAddressID)
FROM Sales.SalesOrderHeader;

--Two colunm same return null by NULLIF and replace 1 by COALESCE
SELECT BillToAddressID,
	   ShipToAddressID,
	   NULLIF(BillToAddressID,ShipToAddressID),
	   COALESCE(NULLIF(BillToAddressID,ShipToAddressID),1)
FROM Sales.SalesOrderHeader
WHERE  COALESCE(NULLIF(BillToAddressID,ShipToAddressID),1) <> 1;



SELECT  FirstName,
		MiddleName,
		COALESCE(MiddleName,FirstName)
From Person.Person;

--REPLACE Funtion
SELECT EmailAddress,
	   REPLACE(EmailAddress,'adventure-works','databuzzkp') AS UpdatedEmail
FROM Person.EmailAddress;


--SUBSTRING Function and TRIM 
SELECT FirstName,
	   SUBSTRING(FirstName,3,5)
	   From Person.Person;


SELECT NAME,
	   TRIM(REPLACE(Upper(SUBSTRING(Name,3,7)),'P','O'))
From Production.Product;


SELECT 
	LTRIM ('  Test'),
	RTRIM ('Test  '),
	TRIM  (' Test  ')

--CHARINDEX FUNCTION
SELECT CHARINDEX ('U','Databuzzkp',3)

SELECT CHARINDEX ('t','Databuzztp',4)