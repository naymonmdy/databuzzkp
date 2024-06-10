--Qrder By Clause
--Question 1
SELECT FirstName, LastName, JobTitle
FROM HumanResources.vEmployeeDepartment
ORDER BY FirstName ASC;


--Question2
SELECT FirstName, LastName, JobTitle
FROM HumanResources.vEmployeeDepartment
ORDER BY FirstName ASC, LastName DESC;


--Question3
SELECT FirstName, LastName, CountryRegionName
FROM Sales.vIndividualCustomer
ORDER BY 3;


--Question4
SELECT FirstName, LastName, CountryRegionName
FROM Sales.vIndividualCustomer
WHERE CountryRegionName IN ('United States', 'France')
ORDER BY CountryRegionName ASC;


--Question 5
SELECT 
    Name,
    AnnualSales,
    YearOpened,
    SquareFeet AS "Store Size",
    NumberEmployees AS "Total Employees"
FROM 
    Sales.vStoreWithDemographics
WHERE 
    AnnualSales > 1000000
    AND NumberEmployees >= 45
ORDER BY 
    "Store Size" DESC,
    "Total Employees" DESC;
