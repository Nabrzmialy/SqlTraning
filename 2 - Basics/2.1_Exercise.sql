-- For all exercises please use table Production.Product
-- 2.1.A -- Find all product with ProductNumber having "BK" anywhere in the name
EXEC [2.1.A_Solution]
-- 2.1.B -- Find all products with ProductNumber having "BK-" at start
-- and 4th letter can't be "R" - for example BK-R... - is not expected product number
EXEC [2.1.B_Solution]
-- 2.1.C -- Find all products with ProductNumber starting:
-- "FK-(letter from A to Z)(digit from 0 to 9)(digit from 0 to 9)(letter from A to Z)-(number 3)(any char)"
EXEC [2.1.C_Solution]
-- 2.1.D -- Find all products having "LN" anywhere OR color of product is red.
EXEC [2.1.D_Solution]
/* 2.1.E -- Find all products:
a) weight is equal or higher than 15
b) AND color is black
c) AND having any size
d) AND List price is higher than 600 and lower than 2500
*/
EXEC [2.1.E_Solution]



