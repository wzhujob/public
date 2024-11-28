#Get-ADComputer -filter "Enabled -eq 'false'" -properties operatingsystem,canonicalname,LastLogonDate | select name,operatingsystem,canonicalname,LastLogonDate | Export-CSV c:\computers.csv -NoTypeInformation
#$_ variable to represent the current object
$computerList=Get-ADComputer -filter "*" -properties OperatingSystem
$computerList | ForEach-Object {
#if ($_.LastLogonDate  -lt (get-date 2024-08-01)){
    if (($_.OperatingSystem -like "*Server*")){
        Write-Host "Computer Name: $($_.Name), Operating System: $($_.OperatingSystem), Distinguished Name: $($_.DistinguishedName)"}
        #Remove-ADComputer -Identity $_.Name
    }
#}
