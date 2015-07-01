ECHO ON
net stop "W3SVC"
net stop "SPAdminV4"
net stop "SPTimerV4"
net stop "SPTraceV4"
net stop "SPUserCodeV4"
net stop "SPWriterV4"
net stop "SPSearch4"
net stop "OSearch14"
net stop "MSSQLSERVER”
net stop "SQLSERVERAGENT”
net stop "MSSQLFDLauncher”
net stop "MSSQLServerOLAPService”
net stop "MsDtsServer100"
net stop "ReportServer”
net stop "SQLWriter”
net stop "SQLSERVERAGENT”
pause
net start "MSSQLSERVER”
net start "SQLSERVERAGENT”
net start "MSSQLFDLauncher”
net start "MSSQLServerOLAPService”
net start "MsDtsServer100"
net start "ReportServer”
net start "SQLWriter”
net start "SQLSERVERAGENT”
net start "W3SVC”
net start "SPAdminV4"
net start "SPTimerV4"
net start "SPTraceV4"
net start "SPUserCodeV4"
net start "SPWriterV4"
net start "SPSearch4"
net start "OSearch14"
PAUSE
