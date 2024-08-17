use AdventureWorks2022

select * from production.product
select * from production.ProductCategory
select * from production.ProductSubcategory


CREATE VIEW dim_product AS
SELECT 
    pp.ProductID,
    pp.Name AS "Product Name",
    ISNULL(PM.Name, pp.Name) AS "Product Model Name",
    ISNULL(pp.Color, 'Multi') AS "Color",
    pp.SafetyStockLevel,
    pp.ReorderPoint,
    pp.StandardCost,
    pp.ListPrice,
    pp.ProductSubcategoryID,
    ISNULL(ps.Name, 'Undefined') AS "Subcategory Name",
    ISNULL(pc.Name, 'Undefined') AS "Category Name"
FROM production.Product pp 
LEFT JOIN production.ProductSubCategory ps ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
LEFT JOIN production.ProductModel pm ON pp.ProductModelID = pm.ProductModelID;


 SELECT * from dim_product;

 SELECT * from person.Person;


 Create view dim_customer as
 SELECT 
	sc.CustomerID,
	pp.Title,CONCAT(pp.FirstName,' ',pp.MiddleName,' ',pp.LastName) as "CustomerName",
	Case 
		When pp.Title in ('Sr.','Mr.') THEN 'Male'
		When pp.Title is Null then 'NA'ELSE 'Female'END Gender,
	sc.TerritoryID,st.Name as "Territory Name",
	pc.Name as "Country",
	pp.BusinessEntityID,pp.PersonType,
    st.[Group] as "Continent",
	sc.StoreID, ISNUll(ss.Name,'Online Store') StoreName,
	ss.SalesPersonID
 From Sales.Customer sc
 Left Join Person.Person pp on sc.PersonID = pp.BusinessEntityID
 Left Join Sales.SalesTerritory st on sc.TerritoryID = st.TerritoryID
 Left Join Sales.Store ss on sc.StoreID = ss.BusinessEntityID
 Left Join Person.CountryRegion pc on st.CountryRegionCode = pc.CountryRegionCode
 Where pp.BusinessEntityID is not null

 select * from dim_customer;


 Create view dim_person as
 select 
	sp.BusinessEntityID "SalesPerson Code",
	sp.TerritoryID,
	CONCAT(pp.FirstName,' ',pp.MiddleName,' ',pp.LastName) AS "Salesperson Name",
	he.OrganizationLevel,
	he.JobTitle,
	CASE he.MaritalStatus when 'M' then 'Married' ELSE 'Single'END as "MaritalStatus",
	CASE he.Gender when 'M' then 'Male' ELSE 'Female'END as "Gender",
	he.HireDate,
	em.EmailAddress	
 from
 Sales.SalesPerson sp
 left join Person.Person pp on sp.BusinessEntityID = pp.BusinessEntityID
 left join HumanResources.Employee he on sp.BusinessEntityID = he.BusinessEntityID
 left join Person.EmailAddress em on sp.BusinessEntityID = em.BusinessEntityID;


 --fct_SalesDetail
create view fct_SalesDetail as
select 
	sod.SalesOrderID,
	sod.SalesOrderDetailID,
	cast(soh.OrderDate as Date) OrderDate,
	cast(soh.shipDate as Date) ShipDate,
	soh.OnlineOrderFlag,
	soh.CustomerID,
	soh.SalesPersonID,
	soh.TerritoryID,
	soh.ShipToAddressID,
	soh.BillToAddressID,
	sod.OrderQty,sod.UnitPrice,sod.UnitPriceDiscount,sod.LineTotal,
	soh.SubTotal,soh.TaxAmt,soh.Freight,soh.TotalDue
from Sales.SalesOrderDetail sod
left join Sales.SalesOrderHeader soh on sod.SalesOrderID = soh.SalesOrderID
select * from Sales.SalesOrderDetail where SalesOrderID = '43659'