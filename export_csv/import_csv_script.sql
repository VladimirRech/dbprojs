--
-- Import CSV Script
--
use WideWorldImporters;

declare @FileLocation varchar(100) = 'C:\Users\rechv\git\dbprojs\export_csv\';
declare @FileName varchar(256) = 'meu_arquivo_2023_11_28.csv';
declare @SchemaName varchar(3) = 'dbo';
declare @TableName varchar(40) = 'Sales_Orders_Report';
declare @FormatFileName varchar(256) = 'import_csv_schema.xml';

declare @SqlCommand NVARCHAR(max);

select @SqlCommand = '
    insert into [' + @SchemaName + '].[' + @TableName + ']
    select * 
    from openrowset(BULK N''' + @FileLocation + @FileName + ''' ,
    firstrow = 2, formatfile = ''' +
    @FileLocation + @FormatFileName + ''',
    format = ''CSV'') as csvdata;'

exec sp_executesql @SqlCommand;

select *
from Sales_Orders_Report

--select @SqlCommand as sql
