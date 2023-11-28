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