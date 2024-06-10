--Where Clause Part 1
--Question 1
select FirstName ,LastName from  Person.Person where 
FirstName = 'Mark';


--Question 2
select top 100 *  from Production.Product where 
ListPrice<>0.00;


--Question 3
select  *  from HumanResources.vEmployee where 
LastName LIKE '[a-c]%';


--Question 4
select  *  from Person.StateProvince where 
CountryRegionCode = 'CA';


--Question 5
select  FirstName AS "Customer First Name",LastName AS " Customer Last Name" from Sales.vIndividualCustomer where 
LastName = 'Smith';


--Question 6
select  *  from Sales.vIndividualCustomer where 
 CountryRegionName = 'Australia' OR (PhoneNumberType= 'Cell' and EmailPromotion= 0);
 
 
 --Question 7
 select  * from HumanResources.vEmployeeDepartment where 
Department in ('Executive' ,'Tool  Design','Engineering');

