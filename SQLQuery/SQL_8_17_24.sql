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


 Create view dim_salesperson as
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

 drop view fct_SalesDetail;
 --fct_SalesDetail
create view fct_SalesDetail as
select 	SOD.SalesOrderID, 	SOD.SalesOrderDetailID,	CAST(SOH.OrderDate As date) OrderDate, 	CAST(SOH.ShipDate as date) ShipDate,	SOH.OnlineOrderFlag,	SOH.CustomerID, 	SOH.SalespersonID,	SOH.TerritoryID, 	SOH.ShipToAddressID, 	SOH.BillToAddressID, 	SOD.ProductID, 	SOD.OrderQty, 	SOD.UnitPrice, 	SOD.UnitPriceDiscount, 	SOD.UnitPrice - (SOD.UnitPrice * SOD.UnitPriceDiscount) AS "UnitPrice After Discount",	ISNULL(PCH.StandardCost,P.StandardCost) AS "Unit Cost",	SOD.LineTotal AS "SalesAmt", 	(SOD.LineTotal/SOH.SubTotal) * SOH.TaxAmt AS "TaxAmt",	(SOD.LineTotal/SOH.SubTotal) * SOH.Freight AS "FreightAmt"from sales.SalesOrderDetail  SODLEFT JOIN sales.SalesOrderHeader SOH on SOD.SalesOrderID = SOH.SalesOrderIDleft join production.ProductCostHistory PCH on SOD.ProductID = PCH.ProductID ANDSOH.OrderDate between PCH.StartDate and PCH.EndDateleft join production.Product P on P.ProductID = sOd.ProductID


select * from fct_SalesDetail;

create view dim_address as
SELECTbea.AddressID,AT.Name AddressType,bea.BusinessEntityID,    A.AddressLine1,A.AddressLine2,A.City,    SP.Name AS StateProvinceName,ST.Name AS TerritoryName,CR.Name AS Country,ST.[Group] AS Continent,A.PostalCodeFROM Person.BusinessEntityAddress BEALEFT JOIN Person.Address A ON BEA.AddressID = A.AddressIDLEFT JOIN Person.StateProvince SP ON A.StateProvinceID = SP.StateProvinceIDLEFT JOIN Person.CountryRegion CR ON SP.CountryRegionCode = CR.CountryRegionCodeLEFT JOIN Person.AddressType AT ON BEA.AddressTypeID = AT.AddressTypeIDLEFT JOIN Sales.SalesTerritory ST ON SP.TerritoryID = ST.TerritoryID