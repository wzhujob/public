'Install Microsoft Teams

Function InstallTeams()
Dim objShell
Set objShell = WScript.CreateObject( "WScript.Shell" )
objShell.Run("\\fileserver\Apps\Software\Teams\teamsbootstrapper.exe -p -o \\fileserver\Apps\Software\Teams\MSTeams-x64.msix")
Set objShell = Nothing
End Function

'Get Computer Name
Set wshNetwork = CreateObject( "WScript.Network" )
strComputerName = wshNetwork.ComputerName

'Match computer name and only install on select computers
Select Case strComputerName
Case "CompName1"
  Call InstallTeams()
Case "CompName2"
  Call InstallTeams()
Case Else
End Select

