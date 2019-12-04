--2
select CompanyName, Address, City, Country from Customers
where City = 'London' or City = 'Madrid'
;
--3 / 4
select ProductName, UnitPrice, UnitsInStock from Products
where UnitPrice >40
order by UnitPrice asc;

--5
select count(*) from Products
where UnitPrice >40

--6
select count(*) from Products
where UnitPrice >40 and UnitsInStock > 100;

--8
select ProductName, UnitPrice
from Products inner join Categories C on Products.CategoryID = C.CategoryID
where CategoryName = 'Seafood'

--9
select count(*)
from Employees
where City = 'London'
  and YEAR(BirthDate) > 1960;

--10
select top 5 FirstName, LastName, BirthDate from Employees
order by YEAR(BirthDate)
;

--11
select BirthDate, City from Employees
where (YEAR(BirthDate) between 1950 and 1955
or YEAR(BirthDate) between 1958 and 1960)
and City='London'

--12
select ProductName from Products
where Discontinued= 0

SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
     TABLE_NAME = 'Products' AND
     COLUMN_NAME = 'Discontinued'

--13
select OrderID, CustomerID, OrderDate from Orders
where OrderDate <= '1996-09-01'

--14
select CompanyName
from Customers
where CompanyName like '%the%';

--15
select CompanyName
from Customers
where CompanyName like '[B,W]%';

--23
select count(*) as Stock, CategoryID from Products
sum
group by CategoryID
order by Stock;

select SUM(UnitsInStock) as Sum, CategoryID from Products
group by CategoryID
order by Sum asc;