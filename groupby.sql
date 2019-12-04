select count(*) from Products  -- policzy też nulle! (count(unitprice) np moze dac inny wynik)
where UnitPrice between 10 and 20

select max(UnitPrice) from Products
where UnitPrice < 20

select max(UnitPrice) as maksymalna, min (UnitPrice) as minimalna, avg(UnitPrice) from Products
where QuantityPerUnit like '%bottle%'

select ProductName, UnitPrice from Products
where UnitPrice > (select avg(UnitPrice) from Products)

select sum((1-Discount)*Quantity*UnitPrice )as orderValue from [Order Details]
where OrderID = 10250

-- 2
select OrderID, max(UnitPrice) from [Order Details]
group by OrderID

select OrderID, max(UnitPrice) as maxPrice from [Order Details]
group by OrderID
order by maxPrice desc

select OrderID, max(UnitPrice) as Maximum, min(UnitPrice) as Minimum from [Order Details]
group by OrderID

select ShipVia, count(*) from Orders
group by ShipVia

select top 1 ShipVia, count(*) as nrOfShipments from Orders
where Year(ShippedDate) = 1997
group by ShipVia
order by nrOfShipments desc

-- 3
select orderid, count(ProductID) as nrOfProducts from [Order Details]
group by orderid
having count(ProductID) > 5

select CustomerID, count(OrderID) as nrOfOrders, sum(Freight) as frieghtSum  from Orders
where YEAR(ShippedDate) = 1998
group by CustomerID
having count(OrderID) > 8
order by sum(Freight) desc

--4 rollup and cube -- rollup is asymmetric
select ProductID, OrderID, sum(UnitPrice) as sumOfUnitPrices from [Order Details]
group by ProductID, OrderID
with rollup
order by ProductID, OrderID


