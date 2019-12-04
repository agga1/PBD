-- 1

-- 2
use library
select m.firstname,
       m.lastname,
       a.state,
       (select count(*)
        from loanhist l
        where m.member_no = l.member_no
          and year(l.in_date) = 2001
          and month(l.in_date) = 12) + (select count(*)
                                        from loanhist l
                                                 join juvenile j2 on l.member_no = j2.member_no
                                        where j2.adult_member_no = m.member_no
                                          and year(l.in_date) = 2001
                                          and month(l.in_date) = 12)
from member m
         join adult a on m.member_no = a.member_no
where (select count(*) from juvenile j where j.adult_member_no = m.member_no) > 2
  and a.state = 'AZ'
union
select m.firstname,
       m.lastname,
       a.state,
       (select count(*)
        from loanhist l
        where m.member_no = l.member_no
          and year(l.in_date) = 2001
          and month(l.in_date) = 12) + (select count(*)
                                        from loanhist l
                                                 join juvenile j2 on l.member_no = j2.member_no
                                        where j2.adult_member_no = m.member_no
                                          and year(l.in_date) = 2001
                                          and month(l.in_date) = 12)
from member m
         join adult a on m.member_no = a.member_no
where (select count(*) from juvenile j where j.adult_member_no = m.member_no) > 3
  and a.state = 'CA';

-- 2 Podział na company, year month i suma freight
use Northwind
select CompanyName, YEAR(O.OrderDate) year, MONTH(O.OrderDate) month, sum(Freight) freight  from Shippers
join Orders O on O.ShipVia = Shippers.ShipperID
group by ShipperID, CompanyName, YEAR(O.OrderDate), MONTH(O.OrderDate)
order by CompanyName, year, month

use Northwind
select s.CompanyName, year(o.OrderDate) year, month(o.OrderDate) month, sum(o.Freight) shipping_cost
from Shippers s
         join Orders o on o.ShipVia = s.ShipperID
group by s.ShipperID, s.CompanyName, year(o.OrderDate), month(o.OrderDate)
order by s.CompanyName, year(o.OrderDate), month(o.OrderDate)

-- 3 Najczęściej wybierana kategoria w 1997 dla każdego klienta
select c.CompanyName,
       (select top 1 CategoryName
        from Orders o
                 join [Order Details] od on o.OrderID = od.OrderID
                 join Products P on od.ProductID = P.ProductID
                 join Categories ca on ca.CategoryID = p.CategoryID
        where o.CustomerID = c.CustomerID and year(o.OrderDate)=1997
        group by ca.CategoryName
           order by count(*) desc ) category
from Customers c

use Northwind
select p1.ProductName, p1.UnitPrice, avg(p2.UnitPrice) [average price] from Products p1
cross join Products p2
group by P1.ProductName, p1.UnitPrice
having p1.UnitPrice > avg(p2.UnitPrice)

--2 Zamówienia z Freight większym niż AVG danego roku
select OrderID from Orders outO
where outO.Freight > (select avg(inO.Freight) from Orders inO where year(inO.OrderDate) = year(outO.OrderDate) )

select outO.OrderID, outO.Freight, (select avg(inO.Freight)from Orders inO where year(inO.OrderDate) = year(outO.OrderDate)) as [year average] from Orders outO
where outO.Freight > (select avg(inO.Freight)from Orders inO where year(inO.OrderDate) = year(outO.OrderDate))

--3 Klienci którzy nie zamówli nigdu nic z kategorii 'Seafood' w trzech wersjach
select distinct CustomerID from Orders
join [Order Details] OD on OD.OrderID = Orders.OrderID
join Products P on OD.ProductID = P.ProductID
join Categories C on P.CategoryID = C.CategoryID
where C.CategoryName = 'Seafood'
order by CustomerID

select CompanyName from Customers
where CustomerID not in (select distinct CustomerID from Orders
    join [Order Details] OD on OD.OrderID = Orders.OrderID
    join Products P on OD.ProductID = P.ProductID
    join Categories C on P.CategoryID = C.CategoryID
    where C.CategoryName = 'Seafood')

select CompanyName from Customers
except
select distinct CompanyName from Customers
    join Orders on Customers.CustomerID = Orders.CustomerID
    join [Order Details] OD on OD.OrderID = Orders.OrderID
    join Products P on OD.ProductID = P.ProductID
    join Categories C on P.CategoryID = C.CategoryID
    where C.CategoryName = 'Seafood'

select distinct C2.CompanyName from Customers Cus
join Orders O on O.CustomerID = Cus.CustomerID
join [Order Details] OD on OD.OrderID = O.OrderID
join Products P on OD.ProductID = P.ProductID
join Categories C on P.CategoryID = C.CategoryID and C.CategoryName = 'Seafood'
right join Customers C2 on C2.CustomerID = Cus.CustomerID
where Cus.CustomerID is null

select CompanyName from Customers outC
 where not exists (select distinct CompanyName from Customers
    join Orders on Customers.CustomerID = Orders.CustomerID
    join [Order Details] OD on OD.OrderID = Orders.OrderID
    join Products P on OD.ProductID = P.ProductID
    join Categories C on P.CategoryID = C.CategoryID
    where Customers.CompanyName =  outC.CompanyName and C.CategoryName = 'Seafood')

-- nazwy i nr tel klientów którym w 1997 przesyłek nie dostarczała United Package
select Cus.CompanyName, Cus.Phone from Customers Cus
where CustomerID not in (
    select CustomerID from Orders
    join Shippers S on S.ShipperID = Orders.ShipVia
    where S.CompanyName = 'United Package' and year(ShippedDate)=1997
    )

select C2.CompanyName, C2.Phone from Customers Cus
join Orders O on Cus.CustomerID = O.CustomerID and year(O.ShippedDate) = 1997
join Shippers S on S.ShipperID= O.ShipVia and S.CompanyName like '%United Package%'
right join Customers C2
on Cus.CustomerID = C2.CustomerID
where Cus.CustomerID is null

select Cus.CompanyName, Cus.Phone from Customers Cus
where not exists (
    select CustomerID from Orders
    join Shippers S on S.ShipperID = Orders.ShipVia
    where S.CompanyName = 'United Package' and year(ShippedDate)=1997 and Cus.CustomerID = Orders.CustomerID
    )

-- Najczęściej wybierana kategoria w 1997 dla każdego klienta
use Northwind
select CustomerID,
       (select top 1 CategoryName from Categories
            join Products on Products.CategoryID = Categories.CategoryID
            join [Order Details] OD on OD.ProductID = Products.ProductID
            join Orders O on OD.OrderID = O.OrderID and O.CustomerID = Cus.CustomerID and Year(O.OrderDate) = 1997
            group by CategoryName
            order by count(CategoryName) desc)
from Customers Cus





