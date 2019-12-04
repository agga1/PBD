-- 1.1
select CompanyName, Phone from Customers
where CustomerID in (select distinct CustomerID from Orders
    join Shippers on ShipVia = ShipperID
    where Shippers.CompanyName = 'United Package' and YEAR(ShippedDate) = 1997)

select distinct C.CompanyName, C.Phone from Customers C
join Orders O on C.CustomerID = O.CustomerID
join Shippers S on S.ShipperID = O.ShipVia
where S.CompanyName = 'United Package' and year(ShippedDate) = 1997

-- 2

select distinct CustomerID from Orders
    join [Order Details] OD on OD.OrderID = Orders.OrderID
    join Products P on OD.ProductID = P.ProductID
    join Categories C on P.CategoryID = C.CategoryID
    where C.CategoryName = 'Confections'

select CompanyName, Phone from Customers
where CustomerID in (select distinct CustomerID from Orders
    join [Order Details] OD on OD.OrderID = Orders.OrderID
    join Products P on OD.ProductID = P.ProductID
    join Categories C on P.CategoryID = C.CategoryID
    where C.CategoryName = 'Confections')

select distinct CompanyName, Phone from Customers
where CustomerID not in (select CustomerID from Orders
    join [Order Details] OD on OD.OrderID = Orders.OrderID
    join Products P on OD.ProductID = P.ProductID
    join Categories C on P.CategoryID = C.CategoryID
    where C.CategoryName = 'Confections'
    group by Orders.CustomerID)

select distinct C.CompanyName, C.Phone from Customers C
join Orders O on O.CustomerID = C.CustomerID
join [Order Details] OD on OD.OrderID = O.OrderID
join Products P on OD.ProductID = P.ProductID
join Categories Cat on P.CategoryID = Cat.CategoryID
where Cat.CategoryName = 'Confections'

select distinct C.CompanyName, C.Phone from Customers C
except
select distinct C.CompanyName, C.Phone from Customers C
join Orders O on O.CustomerID = C.CustomerID
join [Order Details] OD on OD.OrderID = O.OrderID
join Products P on OD.ProductID = P.ProductID
join Categories Cat on P.CategoryID = Cat.CategoryID
where Cat.CategoryName = 'Confections'

-- 2.1
select ProductID, max(Quantity) as [maximum quantity] from [Order Details]
group by ProductID
order by ProductID

-- 2.2
select ProductName from Products
where UnitPrice < (select avg(UnitPrice) from Products)

select p1.ProductName from Products P1
cross join Products P
group by P1.ProductName, p1.UnitPrice
having p1.UnitPrice<avg(p.UnitPrice)

--2.3
select ProductName from Products
where UnitPrice < (select avg(UnitPrice) from Products Pin
    where Pin.CategoryID = Products.CategoryID )

select p1.ProductName, p1.UnitPrice, avg(p2.UnitPrice) as avg_price, p1.UnitPrice - avg(p2.UnitPrice) from Products p1
cross join Products p2
group by p1.ProductName, p1.UnitPrice

