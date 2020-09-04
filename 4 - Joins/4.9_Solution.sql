SELECT 
	soh.SalesOrderID as [Id Zamowienia],
	soh.TotalDue as [Kwota wejsciowa],
	CASE 
		WHEN c1.Name is null THEN 'US Dollar'
		ELSE c1.Name
	END AS [Waluta wejsciowa],
	soh.TotalDue * cr.AverageRate as [Kwota po konwersji],
	c2.Name as [Waluta wyjsciowa]
FROM sales.SalesOrderHeader soh
left JOIN Sales.CurrencyRate cr on soh.CurrencyRateID = cr.CurrencyRateID
left JOIN Sales.Currency c1 on c1.CurrencyCode = cr.FromCurrencyCode
left JOIN Sales.Currency c2 on c2.CurrencyCode = cr.ToCurrencyCode

	
	