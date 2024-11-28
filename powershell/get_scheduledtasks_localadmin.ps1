#2024-10-28 Wei
#Script checks if any scheduled tasks has the principal set as either "Administrator" or "tech"

$version = 1
$versionpath = "C:\Apps\logs\stasks.log"
$versionfolder = "C:\Apps\logs\"
$logpath = "\\fileserver\LoginLog\stasks.log"

function LogToServer($pdata){
    Write-Host $pdata
    Add-Content -Path $logpath -Value $pdata
}
function ScanScheduledTasks{
    try{
        #Add a random delay up to 10 minutes to prevent all the scripts from starting and writing to log file at the same time
        Start-Sleep -Milliseconds (Get-Random 600000)

        LogToServer("$(Get-Date), $(hostname), Script Started")
        ScheduledTask | ForEach-Object {
          #skip Task if it is disabled
          if ($_.State -ne "Disabled"){
            #Write-Host $_.TaskName "has principal:" $_.Principal.UserId
            #Get the principal name
            if ($_.Principal.UserId.Length -gt 0){
              $taskpr = $_.Principal.UserId.ToLower()
            }
            else {
              $taskpr = ""
            }
            if (($taskpr -eq "administrator") -or ($taskpr -eq "tech")){
              LogToServer("$(Get-Date), $(hostname), $($_.TaskName) has principal, $($_.Principal.UserId)")
            }
          }
        }
        #Write version run value to local system, (Add-Content also available)
        if (!(Test-Path -Path $versionfolder)){
            Write-Host "Creating log folder"
            New-Item -Path "C:\Apps\" -Name "logs" -ItemType "directory"
        }
        Set-Content -Path "$versionpath" -Value $version
        LogToServer("$(Get-Date), $(hostname), Script Complete")
    }
    catch{
        Write-Host "Error Scanning Scheduled Tasks:" $_.Exception.Message
    }
}

#check if script has already been run before, it will not run if the same script version has already been run
#open version file and read version value
if (Test-Path -Path $versionpath){
    Write-Host $versionpath "exists."
    try{
        $fileversion = Get-Content -Path $versionpath -TotalCount 1
        Write-Host "version completed is:" $fileversion "vs script version:" $version
        if ($version -gt [Int]$fileversion){
            ScanScheduledTasks
        }
    }
    catch {
        Write-Host "Error Reading Version:" $_.Exception.Message
    }
}
else{
    ScanScheduledTasks
}

