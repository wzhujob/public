#Get-ADComputer -filter "Enabled -eq 'false'" -properties operatingsystem,canonicalname,LastLogonDate | select name,operatingsystem,canonicalname,LastLogonDate | Export-CSV c:\computers.csv -NoTypeInformation
#$_ variable to represent the current object
$computerList=Get-ADComputer -filter "*" -properties LastLogonDate,OperatingSystem
#(get-date 2024-7-30)
$computerList | ForEach-Object {
if ($_.LastLogonDate  -lt ((Get-Date).AddDays(-90)) -and $_.LastLogonDate -gt ((Get-Date).AddDays(-180)) -and $_.LastLogonDate  -gt 1){
    if (($_.OperatingSystem -like "*Windows 1*") -or ($_.OperatingSystem -like "*Windows 8*")){
         Write-Host "Computer Name: $($_.Name), Operating System: $($_.OperatingSystem), Last Logon Date: $($_.LastLogonDate)"}
        #Remove-ADComputer -Identity $_.Name
	#Disable-ADAccount -Identity $_.Name
    }
}
