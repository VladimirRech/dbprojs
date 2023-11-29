--
-- Create the target table to import CSV data.
--
use WideWorldImporters;

create table dbo.Sales_Orders_Report (
    OrderID int not null
    , CustomerID int not null
    , SalespersonPersonID int not null
    , OrderDate Date not null
    , InvoiceID int not null
    , InvoiceDate Date not null
    , TotalDryItems int not null
    , TotalChillerItems int not null
    , TransactionDate Date not null
    , AmountExcludingTax Decimal(18,2) not null
    , OutstandingBalance Decimal(18,2) not null
    , TransactionAmount Decimal(18,2) not null
    , CustomerName nvarchar(100) not null
    , PhoneNumber nvarchar(20) not null
);