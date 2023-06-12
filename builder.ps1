# проверка .\builder.ps1 lol kek
param ($SourcePath, $ArchiveName="file.zip", $DestPath)

if ($null -eq $DestPath) { $DestPath = Get-Content Env:\TEMP }

Write-Output "sourcePath: $SourcePath";
Write-Output "name: $ArchiveName";
Write-Output "destPath: $DestPath";

$DestFileName = Join-Path $DestPath $ArchiveName
Write-Output "DestFileName: $DestFileName"
Compress-Archive -Path $SourcePath -DestinationPath $DestFileName

#$tmp = Get-Content Env:\TEMP

# Write-Output $tmp
#function New-TemporaryDirectory {
#    $parent = [System.IO.Path]::GetTempPath()
#    $name = [System.IO.Path]::GetRandomFileName()
#    New-Item -ItemType Directory -Path (Join-Path $parent $name)
#}