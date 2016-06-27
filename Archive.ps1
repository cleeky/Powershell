#[environment]::getfolderpath(“mydocuments”)
#[Environment+SpecialFolder]::GetNames([Environment+SpecialFolder])
<#
Powershell 5.0 Script
Title: Archiver.ps1
Aurthor: Colin Leek
Date: 21 June 2016
Notes:
This will use the win zip commadn line Tool to Zip all Folders/Files over x days Old

Modification History
====================

Ver           Date           Description
1.0           21/06.2015     Creation of the Script

#>
[int] $DaysToRetain = 90    # a number of days old befor files get Ziped
[string] $MyDocuments = [environment]::getfolderpath(“mydocuments”) 
#[string] $MyDocuments = "C:\Users\Colin\Downloads"
[string] $WinZip = "C:\Program Files\WinZip\WZZIP.EXE"
[String[]]$excluedFolders = Get-content "$MyDocuments\x.excludeList.txt"

<# Functions #>


<# Main Scrpt #>
Clear-Host

#list all Folders which has not been accessed for the rale of $DaysToRetain
$FoldersInMyDocs = Get-ChildItem -Directory -Path "$MyDocuments\*" | Where-Object {$_.LastWriteTime -lt $(get-date).AddDays(-$DaysToRetain)}
$FoldersInMyDocs = $FoldersInMyDocs | Where-Object {$excluedFolders -notcontains $_.name}
$FoldersInMyDocs
#chek all sub folder/files if ther are any files yinger than the retention period take the file name from the list of objects
Foreach ($FolderInMyDocs in $FoldersInMyDocs){
    $ItemsinFolders = Get-ChildItem -Directory -Path "$FolderInMyDocs\*" | Where-Object {$_.LastWriteTime -ge $(get-date).AddDays(-$DaysToRetain)}
    $ItemsinFolders = $ItemsinFolders |Where-Object ($excluedFolders -notcontains $_.name)
    if ($ItemsinFolders -ne $null){
        $temp =$FoldersInMyDocs |  Where-Object {$_.FullName -ne $FolderInMyDocs.FullName}
        $FoldersInMyDocs = $temp
    }
}
#Zip All Folder in $FoldersInMyDocs
<#
Foreach ($FolderInMyDocs in $FoldersInMyDocs){
    $filename =$FolderInMyDocs.fullname
    & $WinZip -a -P -r "$filename.zip" "$filename\*.*" 
    #& $WinZip -h
 Write-Host "."
}
#>

# Now to cehck all Fub Folders to file which could be compressed.