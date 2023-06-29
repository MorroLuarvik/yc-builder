Write-Output "Misc script"

function CreateArchive($sourceFolder) {
    $archFolder = [System.IO.Path]::GetTempPath()
    $archName = [System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetRandomFileName()) + ".zip"

    $destPath = Join-Path $archFolder $archName

    Compress-Archive -Path $sourceFolder -DestinationPath $destPath

    return $destPath
}


function DeleteArchive($fileName) {
    Remove-Item $fileName
}