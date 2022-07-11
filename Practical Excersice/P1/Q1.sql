--Question01
--Northwind Database
USE Northwind
--Query01
SELECT s.phone
FROM Suppliers s
WHERE s.CompanyName LIKE 's%';
--Query02
SELECT e.FirstName, e.LastName
FROM Employees e JOIN Orders o
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(*) > 3;
--Query03
--sene estekhdam mishe az moghei ke estekhdam shodan ta alan 
-- year in sen ro ma neshoon midim
-- age sal ya tarikh estekhdam ro mikhast hire date kafi bud
-- sene estekhdam dar in query be aanie meghdar kar kardan hast
-- ke date alan ro az hiredate kam mikonim
SELECT e.LastName, DATEDIFF(YEAR, e.hiredate, GETDATE()) AS WorkingTime
FROM Employees e
WHERE e.Title != 'Sales Representative';
--age manzoor az sen estekhdam sen karmand dar roozie ke estekhdam shode bayad
--sal e estekhdam ro az sale tavalod kam konimx
SELECT e.LastName, DATEDIFF(YEAR, e.BirthDate, e.hiredate) AS AgeOf_StartWorking
FROM Employees e
WHERE e.Title != 'Sales Representative';
--Query04
SELECT c.ContactName, c.Address
FROM Customers c JOIN Orders o on c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID 
GROUP BY c.CustomerID, c.ContactName, c.Address	
HAVING SUM(od.Quantity*od.UnitPrice) > 6000;
--Query05
SELECT SUM(od.Quantity) NumOfProductsSendToFrance
 FROM [Order Details] od
 JOIN Orders o ON od.OrderID = O.OrderID
 WHERE O.ShipCountry = 'France';