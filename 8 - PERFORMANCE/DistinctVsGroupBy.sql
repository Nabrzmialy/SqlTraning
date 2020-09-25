select od.ProductID,
    (select Name
     from Production.Product p
     where p.ProductID = od.ProductID) as ProductName
from Sales.SalesOrderDetail od
group by od.ProductID;
 
select distinct 
	od.ProductID,
     (select Name
      from Production.Product p
      where p.ProductID = od.ProductID) as ProductName
from Sales.SalesOrderDetail od;
