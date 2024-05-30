# About EXPORT_CSV
That is a study about how to export and import data in CSV format in SQL Server databases.
It's based on the blog post from Edward Pollack: [Exporting and Importing Data into SQL Server Using Files](https://www.red-gate.com/simple-talk/databases/sql-server/t-sql-programming-sql-server/exporting-and-importin-data-into-sql-server-using-files/)

# Downloads
* [Wide World Importers sample database v1.0](https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0): sample database used in the post.
* [Como criar um SQL Server Job](https://learn.microsoft.com/pt-br/sql/ssms/agent/create-a-job?view=sql-server-ver16)

# Notes
* Failed to restore database with the .bak file.
* Used bacpac file.

# SQL Server Agent
## The Issue
Can't activate the process

## Workarounds
1. Fix the permission: don't work.
2. Install Windows Process Activation Service, MSMQ, Windows Identity Foundation 3.5 and Windows Power Shell 3.0: don't work.
3. Testing run stand alone Power Shell script, without SQL Server Agent

## Final solution
1. Ignoring the Create SQL Server Agent because I don't want to reinstall SQL Server in my machine at this moment.
2. Maybe this issue is related to the fact that my Windows 11 Edition is Home Editon.
3. I choose to run the shell script from Power Shell and it workd.

# Issue when trying to import
When trying to execute the script into the file IMPORT_CSV_SCRIPT.sql SQL Server throw this error Message:

````
Msg 4864, Level 16, State 1, Line 2
Bulk load data conversion error (type mismatch or invalid character for the specified codepage) for row 2, column 10 (AmountExcludingTax).
Msg 4864, Level 16, State 1, Line 2
Bulk load data conversion error (type mismatch or invalid character for the specified codepage) for row 3, column 10 (AmountExcludingTax).
````

The SQL Server documentation said that I don't have the option to select the decimal separator. [XML Format Files (SQL Server)](https://learn.microsoft.com/en-us/sql/relational-databases/import-export/xml-format-files-sql-server?view=sql-server-ver16), It don't have an [XML attribute]() to set this. 

### Workaround 1 - change the field separator in CSV file.
Doosn't work.