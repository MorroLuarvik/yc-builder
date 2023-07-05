param ($SourceDir, $ProjectFolder, $ProjectFile = "project.json")

. $PSScriptRoot\misc.ps1

<#
    получить список функций
    yc sls fn list --format json 

    получить функцию hello
    yc sls fn get --name hello --format json
#>

# останавливать выполнение скрипта при ошибке
$ErrorActionPreference = "Stop"

Write-Output "Start executor"

function local:PrintHandler($handler = "default") {
    Write-Output "hh: $handler"
}

$kek = @{handler = "single"; test = 314}
#$kek.GetType().FullName
PrintHandler @kek


$Project = Get-Content (Join-Path $ProjectFolder $ProjectFile) | ConvertFrom-Json # | ConvertTo-HashTable
$Project.functions | Get-Member -type NoteProperty | ForEach-Object {  #  
    
    $func = $Project.functions."$($_.Name)"
    #$func.GetType().FullName

    Write-Output $_.Name
    #PrintHandler $func
    ##Write-Output $Project.functions."$($_.Name)".handler
    Write-Output " ============== "
}

HasFunction hello1

<#
$dest = CreateArchive $SourceDir

Write-Output "DestFileName: $dest"

Read-Host "Press Enter to continue"

Remove-Item $dest
#>

Write-Output "Finish executor"
 