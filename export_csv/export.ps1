$SQLServer = get-content Env:COMPUTERNAME
$SQLDBName = "WideWorldImporters"
$SQLConnection = New-Object System.Data.SqlClient.SqlConnection
$SQLConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True;"
$SQLCmd = New-Object System.Data.SqlClient.SqlCommand
$SQLCmd.Connection = $SQLConnection
$SQLAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$FilePath = ".\"
$Delimiter = ","
$Today = Get-Date -UFormat "%y_%m_%d"
$SQLQuery = "
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
"

$SQLCmd.CommandText = $SQLQuery
$SQLAdapter.SelectCommand = $SQLCmd
$DataSet = New-Object System.Data.DataSet
$SQLAdapter.Fill($DataSet)
$FileName = "meu_arquivo_" + $Today + ".csv"
$FullPathWithFileName = $FilePath + $FileName
$DataSet.Tables[0] | export-csv -Delimiter $Delimiter -Path $FullPathWithFileName -NoTypeInformation