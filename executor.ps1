param ($SourceDir, $ProjectFolder, $ProjectFile = "project.json")

. $PSScriptRoot\misc.ps1

# останавливать выполнение скрипта при ошибке
$ErrorActionPreference = "Stop"

Write-Output "Start executor"

function local:PrintHandler($handler = "default") {
    Write-Output $handler
}

$Project = Get-Content (Join-Path $ProjectFolder $ProjectFile) | ConvertFrom-Json
$Project.functions | Get-Member -type NoteProperty | ForEach-Object { 
    $function = $Project.functions."$($_.Name)"

    Write-Output $_.Name
    PrintHandler @function
    ##Write-Output $Project.functions."$($_.Name)".handler
    Write-Output " ============== "
}

<#
$dest = CreateArchive $SourceDir

Write-Output "DestFileName: $dest"

Read-Host "Press Enter to continue"

Remove-Item $dest
#>

Write-Output "Finish executor"
 