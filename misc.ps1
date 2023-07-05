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

function HasFunction($functionName) { #READY
    $ErrorActionPreference = "Continue"
    yc sls fn get --name $functionName --format json 2> $error | Out-Null
    $ErrorActionPreference = "Stop"

    if ($error) { return $false }

    return $true
}

function GetFunctionList() {
    return yc sls fn list --format json | ConvertFrom-Json
}

function ConvertTo-Hashtable {
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )

    process {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ($null -eq $InputObject) {
            return $null
        }

        ## Check if the input is an array or collection. If so, we also need to convert
        ## those types into hash tables as well. This function will convert all child
        ## objects into hash tables (if applicable)
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
            $collection = @(
                foreach ($object in $InputObject) {
                    ConvertTo-Hashtable -InputObject $object
                }
            )

            ## Return the array but don't enumerate it because the object may be pretty complex
            Write-Output -NoEnumerate $collection
        } elseif ($InputObject -is [psobject]) { ## If the object has properties that need enumeration
            ## Convert it to its own hash table and return it
            $hash = @{}
            foreach ($property in $InputObject.PSObject.Properties) {
                $hash[$property.Name] = ConvertTo-Hashtable -InputObject $property.Value
            }
            $hash
        } else {
            ## If the object isn't an array, collection, or other object, it's already a hash table
            ## So just return it.
            $InputObject
        }
    }
}
