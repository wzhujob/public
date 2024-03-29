'Install Microsoft Teams

Function InstallTeams()
Dim objShell
Set objShell = WScript.CreateObject( "WScript.Shell" )
objShell.Run("\\fileserver\Apps\Software\Teams\teamsbootstrapper.exe -p")
Set objShell = Nothing
End Function

Call InstallTeams()
