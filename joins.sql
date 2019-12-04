-- lab 5
select bossess.EmployeeID as przełożony, emp.EmployeeID as podwładny from Employees bossess
join Employees emp on bossess.EmployeeID = emp.ReportsTo

select bosses.FirstName + bosses.LastName as employee from Employees bosses
left join Employees sub on  bosses.EmployeeID = sub.ReportsTo
where sub.EmployeeID is null

select (FirstName + ' ' + LastName) as name, city, postalcode, 'prac' from Employees
    union -- or intersect or union all
select CompanyName, City, PostalCode, 'klient'
from Customers;

select sum(Quantity) as orderedUnits , CategoryName from [Order Details]
join Products P on [Order Details].ProductID = P.ProductID
join Categories C on P.CategoryID = C.CategoryID
group by  C.CategoryName

select sum(Quantity) as totalQuantity, O.OrderID, C.CompanyName from [Order Details]
join Orders O on [Order Details].OrderID = O.OrderID
join Customers C on O.CustomerID = C.CustomerID
group by O.OrderID, C.CompanyName
order by sum(Quantity)

select  Quantity*UnitPrice*(1-Discount) as orderValue, O.OrderID, CompanyName from Customers
left join Orders O on Customers.CustomerID = O.CustomerID
left join [Order Details] OD on OD.OrderID = O.OrderID
