-- 1
select OrderId, sum((1-Discount)*UnitPrice*Quantity) as OrderValue from [Order Details]
group by OrderId
order by OrderValue desc

select top 10 OrderId, sum((1-Discount)*UnitPrice*Quantity) as OrderValue from [Order Details]
group by OrderId
order by OrderValue desc

-- 2
select ProductID, sum(Quantity) as orderedUnits from [Order Details]
where ProductID<3
group by ProductID
order by ProductID

select ProductID, sum(Quantity) as orderedUnits from [Order Details]
group by ProductID
order by ProductID

select OrderID, sum((1-Discount)*UnitPrice*Quantity) as OrderValue, sum(Quantity) as quantityOrdered from [Order Details]
group by OrderID
having sum(Quantity) > 250

-- 3
select EmployeeID, count(*) as nrOfManagedOrders from Orders
group by EmployeeID
order by EmployeeID

select ShipVia, sum(Freight) as [opłata za przesyłkę] from Orders
group by ShipVia
order by ShipVia

select ShipVia, sum(Freight) as [opłata za przesyłkę] from Orders
where YEAR(ShippedDate) between 1996 and 1997 -- inclusive
group by ShipVia
order by ShipVia

-- 3.3 cd
select ShipVia, sum(Freight) as [opłata za przesyłkę] from Orders
where YEAR(ShippedDate) = 1997 or YEAR(ShippedDate) = 1996
group by ShipVia
order by ShipVia
-- 3.4
select EmployeeID, count(*) as nrOfOrders, YEAR(OrderDate) as OrderYear, MONTH(OrderDate) as OrderMonth from Orders
group by EmployeeID, YEAR(OrderDate), MONTH(OrderDate)
order by EmployeeID

select EmployeeID, count(*) as nrOfOrders, YEAR(OrderDate) as OrderYear, MONTH(OrderDate) as OrderMonth from Orders
group by EmployeeID, YEAR(OrderDate), MONTH(OrderDate)
with rollup
order by EmployeeID, YEAR(OrderDate), MONTH(OrderDate)

-- 3.5
select CategoryID, max(UnitPrice) as MaxUnitPrice, min(UnitPrice) as MinUnitPrice from Products
group by CategoryID



