-- 4
-- 4.1
select [without freight].OrderID, (value + Freight) as [total value]
from (select Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount)) as value
    from Orders inner join [Order Details]
    on Orders.OrderID = [Order Details].OrderID
    group by Orders.OrderID) as [without freight]
inner join Orders
on Orders.OrderID = [without freight].OrderID
where [without freight].OrderID = 10250
order by [total value]
-- 4.1 alt
select Freight + (SELECT sum(Quantity*UnitPrice*(1-Discount))
from [Order Details]
where OrderID= 10250)
from Orders
where OrderID = 10250
-- 4.2
select [without freight].OrderID, (value + Freight) as [total value]
from (select Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount)) as value
    from Orders inner join [Order Details]
    on Orders.OrderID = [Order Details].OrderID
    group by Orders.OrderID) as [without freight]
inner join Orders
on Orders.OrderID = [without freight].OrderID
order by [total value]
-- 4.2 alt
select Orders.OrderID , Freight + (SELECT sum(Quantity*UnitPrice*(1-Discount))
from [Order Details]
    where Orders.OrderID = [Order Details].OrderID) as total
from Orders
order by 1

--4.3
select Address, City, Country from Customers
where CustomerID not in (select Orders.CustomerID from Orders where Year(OrderDate)=1997 )
--4.2
select ProductName from Products
where (select count(distinct Orders.CustomerID) from [Order Details] inner join Orders on [Order Details].OrderID = Orders.OrderID
    where [Order Details].ProductID = Products.ProductID) >1
order by 1
-- z wysw licznika
select ProductName, (select count(distinct Orders.CustomerID) from [Order Details] inner join Orders on [Order Details].OrderID = Orders.OrderID
    where [Order Details].ProductID = Products.ProductID) from Products
where (select count(distinct Orders.CustomerID) from [Order Details] inner join Orders on [Order Details].OrderID = Orders.OrderID
    where [Order Details].ProductID = Products.ProductID) >1
order by 1
-- bez podzapytania
select ProductName from products
join [Order Details] OD on OD.ProductID = Products.ProductID
join Orders O on OD.OrderID = O.OrderID
group by Products.ProductName
having count(distinct CustomerID)>1
order by 1

select ProductName, count(distinct CustomerID) from products
join [Order Details] OD on OD.ProductID = Products.ProductID
join Orders O on OD.OrderID = O.OrderID
group by Products.ProductName
having count(distinct CustomerID)>1
order by 1

