Write-Verbose "Importing Functions"



foreach ($folder in 'Classes', 'Private', 'Public')
{
    $root = Join-Path -Path $PSScriptRoot -ChildPath $folder
    if (Test-Path -Path $root)
    {
        Write-Verbose "Processing folder $root"

        Get-ChildItem -Path $root -Filter *.ps1 |
            Where-Object Name -NotLike *.Tests.ps1 |
            ForEach-Object {
                Write-Verbose "dot source $($_.FullName)"
                . $_.FullName
            }
    }
}

Export-ModuleMember -Function (
    Get-ChildItem -Path (Join-Path -Path ${PSScriptRoot} -ChildPath Public/*.ps1)
).BaseName
