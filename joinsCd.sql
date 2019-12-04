select CompanyName from Customers
 -- 1
select  ProductName, UnitPrice, Address from Products
inner join Suppliers on Products.SupplierID=Suppliers.SupplierID
where UnitPrice between  20.0 AND 30.0

select  ProductName, UnitsInStock from Products
inner join Suppliers S on Products.SupplierID = S.SupplierID
where CompanyName = 'Tokyo Traders'

select Address, OrderID from Customers
left join Orders O on Customers.CustomerID = O.CustomerID
where OrderID is null

select CompanyName, Phone from Products inner join  Suppliers S on Products.SupplierID = S.SupplierID
where UnitsInStock = 0
 -- 3

select ProductName, UnitPrice, Address, City, Country from Products inner join Categories C on Products.CategoryID = C.CategoryID
inner join Suppliers S on Products.SupplierID = S.SupplierID
where UnitPrice between 20.0 and 30 and
      CategoryName = 'Meat/Poultry'

select ProductName, UnitPrice, CompanyName from Products inner join  Categories C on Products.CategoryID = C.CategoryID
inner join Suppliers S on Products.SupplierID = S.SupplierID
where CategoryName = 'Confections'

select C.CompanyName, C.Phone
from Orders inner join Customers C on Orders.CustomerID = C.CustomerID
    inner join Shippers on Orders.ShipVia=ShipperID
where Shippers.CompanyName = 'United Package' and
      YEAR(ShippedDate) = 1997

select distinct Customers.CompanyName, Customers.Phone
from Customers inner join Orders O on Customers.CustomerID = O.CustomerID
inner join [Order Details] as OD on OD.OrderID=O.OrderID
inner join Products P on OD.ProductID = P.ProductID
inner join Categories C on P.CategoryID = C.CategoryID
where CategoryName = 'Confections';

