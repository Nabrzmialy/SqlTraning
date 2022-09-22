









--- QUERY B --
------------------- Question no 1 ---------------------
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

select idSupplier, nameSupplier, country
from dbo.Supplier
WHERE   idSupplier <= 160
order by idSupplier


ROLLBACK
















--- QUERY B --
------------------- Question no 2 ---------------------
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

select idSupplier, nameSupplier, country, idCategory
from dbo.Supplier
WHERE   idSupplier <= 160
order by idSupplier


---
--WHILE (1=1)
--BEGIN
--	select idSupplier, country
--	from dbo.Supplier WHERE idSupplier <= 160
--END
---







--- QUERY B --
------------------- Question no 3 ---------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

select idSupplier, nameSupplier, country
from dbo.Supplier 
WHERE idSupplier <= 160
order by idSupplier









--- QUERY B --
------------------- Question no 4 ---------------------
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

select idSupplier, nameSupplier, country, idCategory
from dbo.Supplier 
WHERE idSupplier <= 160
order by idSupplier
















--- QUERY B --
------------------- Question no 5---------------------
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

select idSupplier, nameSupplier, country, idCategory
from dbo.Supplier WITH (NOLOCK)
WHERE idSupplier <= 160
order by idSupplier








--- QUERY B --
------------------- Question no 6---------------------
SET TRANSACTION ISOLATION LEVEL READ COMMITTED 

BEGIN TRAN
	select idSupplier, country
	from dbo.Supplier WHERE idSupplier <= 160


	-- update time

	select  idSupplier, country
	from dbo.Supplier WHERE idSupplier <= 160
COMMIT









--- QUERY B --
------------------- Question no 7---------------------
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

BEGIN TRAN
	select idSupplier, country
	from dbo.Supplier WHERE idSupplier <= 160
	
	--Update Time

	select idSupplier, country
	from dbo.Supplier WHERE idSupplier <= 160
COMMIT




--- QUERY B --
------------------- Question no 8 ---------------------
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ


-- 2. Select
BEGIN TRAN
	select idSupplier, nameSupplier, country
	from dbo.Supplier WHERE idSupplier <= 160
	
	--  3. insert time

	-- 4. Select
	select idSupplier, nameSupplier, country
	from dbo.Supplier WHERE idSupplier <= 160
COMMIT








--- QUERY B --
------------------- Question no 9 ---------------------
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- 2. Select
BEGIN TRAN
	select idSupplier, nameSupplier, country
	from dbo.Supplier WHERE idSupplier <= 160
	
	select idSupplier, nameSupplier, country
	from dbo.Supplier WHERE idSupplier <= 160
COMMIT











