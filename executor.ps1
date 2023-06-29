param ($SourceDir)

. $PSScriptRoot\misc.ps1

Write-Output "Start executor"

$dest = CreateArchive $SourceDir

Write-Output "DestFileName: $dest"

Read-Host "Press Enter to continue"

Remove-Item $dest

Write-Output "Finish executor"
 