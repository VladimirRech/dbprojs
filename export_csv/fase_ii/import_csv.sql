/*
use WideWorldImporters;
go
select so.OrderID
    , sc.CustomerName
from sales.Orders so
join Sales.Invoices inv on inv.OrderID = so.OrderID
left join Sales.CustomerTransactions sct on sct.InvoiceID = inv.InvoiceID
join Sales.customers sc on sc.CustomerID = so.CustomerID
where so.OrderDate BETWEEN '2016-01-01' and '2016-05-31'
*/
-- BULK INSERT
bulk insert WideWorldImporters.dbo.sales_orders_report
from 'C:\Users\rechv\git\dbprojs\export_csv\fase_ii\WideWorldImporters_sales.Orders_2023_12_15.csv'
with (
	FORMAT = 'CSV'
	, FIRSTROW = 2
	, FIELDTERMINATOR = ';'
	--, DATAFILETYPE = 'char'
	)

select top 100 * from WideWorldImporters..Sales_Orders_Report