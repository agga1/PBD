select * from products -- CASE INSENSITIVE LANG!!
where QuantityPerUnit like '%bottle%'

select * from Employees
where LastName >= 'b' and LastName < 'm' -- alternative to like

select CategoryName from Categories
where Description like '%,%'

select OrderID,ShippedDate, OrderDate, CustomerID from Orders
where (ShippedDate is NULL or ShippedDate > getdate())
and ShipCountry = 'Argentina'

select CompanyName, Country from Customers
order by Country, CompanyName

select CategoryID, ProductName, UnitPrice from Products
order by CategoryID, UnitPrice desc

select CompanyName, Country from Customers
where Country in ('Japan', 'Italy')
order by Country, CompanyName -- alt. order by 2, 1 (wg selecta)

select CompanyName, Country from Customers

select FirstName, LastName, 'Identification number: ' as descript, 3,  EmployeeID from Employees -- new static columns

select distinct  ShipCountry, ShipCity from Orders -- all unique combinations of 2 col

select orderid, UnitPrice*1.05 as newPrice from [Order Details] -- as is opt.

select  FirstName + ' ' + LastName as [Imie i nazwisko] from Employees

select ProductID, UnitPrice*Quantity*(1-Discount) from [Order Details]
where OrderID = 10250

select top 5 with ties CompanyName from Customers
where Country in ('Argentina', 'Italy')

select CompanyName, Phone, Fax, Phone+ isnull(', '+Fax, '') from Suppliers





