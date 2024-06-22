--
SELECT * From
HumanResources.Employee;

/*

ER Diagram
JOIN TABLE


Entity => Table
Key Attribute => ID
Attribute => field or column
Composite => name (first ,middle,last) 
Multivalue attribute ==> eg phone 
Drived attribute => birthdate or salary


Relationship 
*/

--CASE
SELECT
    BusinessEntityID,
    CASE
        WHEN JobTitle LIKE '%Manager%' THEN 'Manager Level'
        WHEN JobTitle LIKE '%Specialist%' THEN 'Manager Level'
        WHEN JobTitle LIKE '%Assistant%' THEN 'Assistant Level'
        ELSE 'Other'
    END AS JobTitle
FROM HumanResources.Employee;


SELECT 
	CASE OrganizationLevel 
		When 1 Then 'Assistant'
		When 2 Then 'Officer'
		When 3 Then 'Manager'
	Else 'Other' END as Category
From HumanResources.Employee;


SELECT 
	CASE  
		When OrganizationLevel > 3  Then 'management'
		Else 'Other' END as Category
From HumanResources.Employee;