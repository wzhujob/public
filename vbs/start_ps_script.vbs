Set objShell = CreateObject("Wscript.Shell")
objShell.Run("powershell.exe -file \\domainserver\SYSVOL\domainserver\Policies\{policy-id-string}\backupUserFolders.ps1")
