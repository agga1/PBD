-- 1
-- 1.1
select sum(Quantity) as [total quantity], [Order Details].OrderID, CompanyName from [Order Details]
inner join Orders on [Order Details].OrderID = Orders.OrderID
inner join Customers C on Orders.CustomerID = C.CustomerID
group by [Order Details].OrderID, CompanyName
-- 1.2
select sum(Quantity) as [total quantity], [Order Details].OrderID, CompanyName from [Order Details]
inner join Orders on [Order Details].OrderID = Orders.OrderID
inner join Customers C on Orders.CustomerID = C.CustomerID
group by [Order Details].OrderID, CompanyName
having sum(Quantity) > 250
-- 1.3
select sum(UnitPrice*Quantity*(1-Discount)) as value, [Order Details].OrderID, C.CompanyName from [Order Details]
inner join Orders O on [Order Details].OrderID = O.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
group by [Order Details].OrderID, C.CompanyName
-- 1.4
select sum(UnitPrice*Quantity*(1-Discount)) as value, [Order Details].OrderID, C.CompanyName from [Order Details]
inner join Orders O on [Order Details].OrderID = O.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
group by [Order Details].OrderID, C.CompanyName
having sum(Quantity) > 250
-- 1.5
select sum(UnitPrice*Quantity*(1-Discount)) as value, [Order Details].OrderID, C.CompanyName, E.FirstName, E.LastName from [Order Details]
inner join Orders O on [Order Details].OrderID = O.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
inner join Employees E on E.EmployeeID = O.EmployeeID
group by [Order Details].OrderID, C.CompanyName, E.FirstName, E.LastName
having sum(Quantity) > 250

-- 2 -----------------------------------------------------------------------------------------------
-- 2.1
select CategoryName, sum(Quantity) as [total quantity] from Products
inner join Categories C on Products.CategoryID = C.CategoryID
inner join [Order Details] OD on OD.ProductID = Products.ProductID
group by CategoryName

--2.2
select CategoryName, sum(Quantity*OD.UnitPrice*(1-Discount)) as [total value] from Products
inner join Categories C on Products.CategoryID = C.CategoryID
inner join [Order Details] OD on OD.ProductID = Products.ProductID
group by CategoryName

--2.3
select CategoryName, sum(Quantity*OD.UnitPrice*(1-Discount)) as value from Products
inner join Categories C on Products.CategoryID = C.CategoryID
inner join [Order Details] OD on OD.ProductID = Products.ProductID
group by CategoryName
order by value

--2.3 b
select CategoryName, sum(Quantity*OD.UnitPrice*(1-Discount)) as value from Products
inner join Categories C on Products.CategoryID = C.CategoryID
inner join [Order Details] OD on OD.ProductID = Products.ProductID
group by CategoryName
order by sum(Quantity)

-- 2.4

select OD.OrderID, sum(Quantity*OD.UnitPrice*(1-Discount))+ Freight as [total value] from [Order Details] OD
inner join Orders O on OD.OrderID = O.OrderID
group by OD.OrderID, Freight
order by [total value]

-- 2.4 wersja z podzapytaniem
select [without freight].OrderID, (value + Freight) as [total value]
from (select Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount)) as value
    from Orders
    inner join [Order Details]
    on Orders.OrderID = [Order Details].OrderID
    group by Orders.OrderID) as [without freight]
inner join Orders
on Orders.OrderID = [without freight].OrderID
order by [total value]


-- 3
select CompanyName, count(CompanyName) as [nr of shipped orders in 1997] from Orders
inner join Shippers on Shippers.ShipperID = Orders.ShipVia
where Year(ShippedDate) = 1997
group by CompanyName
--3.2
select top 1 CompanyName, count(CompanyName) as [nr of shipped orders] from Orders
inner join Shippers on Shippers.ShipperID = Orders.ShipVia
where Year(ShippedDate) = 1997
group by CompanyName
order by [nr of shipped orders] desc
-- 3.3
select sum(Quantity*OD.UnitPrice*(1-Discount)) as [total value], E.FirstName, E.LastName from [Order Details] OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Employees E on O.EmployeeID = E.EmployeeID
group by E.EmployeeID, E.FirstName, E.LastName


-- 3.4
select top 1 E.FirstName, E.LastName, count(O.OrderID) as [nr of managed orders] from Employees E
join Orders O on E.EmployeeID = O.EmployeeID
where YEAR(O.OrderDate) = 1997
group by E.EmployeeID, E.FirstName, E.LastName
order by [nr of managed orders] desc

-- 3.5
select sum(Quantity*OD.UnitPrice*(1-Discount)) as value, E.FirstName, E.LastName from [Order Details] OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Employees E on O.EmployeeID = E.EmployeeID
where YEAR(OrderDate) = 1997
group by E.EmployeeID, E.FirstName, E.LastName
order by value desc

--4
select sum(Quantity*OD.UnitPrice*(1-Discount)) as value, E.FirstName, E.LastName from [Order Details] OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Employees E on O.EmployeeID = E.EmployeeID
group by E.EmployeeID, E.FirstName, E.LastName

-- a) wersja z podzapytaniem
select sum(Quantity*OD.UnitPrice*(1-Discount)) as value, E.FirstName, E.LastName from [Order Details] OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Employees E on O.EmployeeID = E.EmployeeID
where E.EmployeeID in (select distinct ReportsTo from Employees) -- or not in
group by E.EmployeeID, E.FirstName, E.LastName

-- b) wersja z podzapytaniem
select sum(Quantity*OD.UnitPrice*(1-Discount)) as value, E.FirstName, E.LastName from [Order Details] OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Employees E on O.EmployeeID = E.EmployeeID
where E.EmployeeID not in (select ReportsTo from Employees where ReportsTo is not null) -- or not in
group by E.EmployeeID, E.FirstName, E.LastName
-- b) z left joinem
select sum(Quantity *OD.UnitPrice*(1-Discount)) as value, E.FirstName, E.LastName from [Order Details] OD
inner join Orders O on OD.OrderID = O.OrderID
inner join Employees E on O.EmployeeID = E.EmployeeID
left join Employees SUB on E.EmployeeID = SUB.ReportsTo
where SUB.EmployeeID is null
group by E.EmployeeID, E.FirstName, E.LastName
