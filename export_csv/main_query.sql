-- Main select
use WideWorldImporters;


select so.OrderID
    , so.CustomerID
    , so.SalespersonPersonID
    , so.OrderDate
    , inv.InvoiceID
    , inv.InvoiceDate
    , inv.TotalDryItems
    , inv.TotalChillerItems
    , sct.TransactionDate
    , sct.AmountExcludingTax
    , sct.OutstandingBalance
    , sct.TransactionAmount
    , sc.CustomerName
    , sc.PhoneNumber
from sales.Orders so
join Sales.Invoices inv on inv.OrderID = so.OrderID
left join Sales.CustomerTransactions sct on sct.InvoiceID = inv.InvoiceID
join Sales.customers sc on sc.CustomerID = so.CustomerID
where so.OrderDate BETWEEN '2016-01-01' and '2016-05-31'