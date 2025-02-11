#Get-ADComputer -filter "Enabled -eq 'false'" -properties operatingsystem,canonicalname,LastLogonDate | select name,operatingsystem,canonicalname,LastLogonDate | Export-CSV c:\computers.csv -NoTypeInformation
#$_ variable to represent the current object
$computerList=Get-ADComputer -filter "*" -properties ms-Mcs-AdmPwdExpirationTime,OperatingSystem
$computerList | ForEach-Object {
if ($_.{ms-Mcs-AdmPwdExpirationTime} -eq $null -and ($_.OperatingSystem -like "*Server*")){
         Write-Host "Computer Name: $($_.Name), Operating System: $($_.OperatingSystem), Laps Expire Time: $($_.{ms-Mcs-AdmPwdExpirationTime})"}
}

