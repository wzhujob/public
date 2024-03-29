$filelist = Get-ChildItem -Path "C:\temp\" -Filter t*.txt -Recurse
Write-Host $filelist
foreach ($fileitem in $filelist)
{
    Write-Host "Processing file:" $fileitem.FullName
    $newfileitem = $fileitem.FullName + ".bak1"
    #Write-Host $newfileitem
    Rename-Item -Path $fileitem.FullName -NewName $newfileitem
    #Remove-Item $fileitem.FullName
}
