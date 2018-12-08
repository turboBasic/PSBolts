Write-Verbose "Importing Functions"

$fileParameters = @{
    Recurse = $true
    Filter  = '*.ps1'
    Exclude = '*.Tests.ps1'
    ErrorAction = 'SilentlyContinue'
}


$Public = @( Get-ChildItem -Path ${PSScriptRoot}/Public/* @fileParameters )

$All =    @( Get-ChildItem -Path ${PSScriptRoot}/Private/* @fileParameters ) +
          @( Get-ChildItem -Path ${PSScriptRoot}/Classes/* @fileParameters ) +
          $Public

foreach ($import in $All.FullName)
{
    Write-Verbose "dot source $import"
    try 
    {
        . $import
    }
    catch
    {
        Write-Error -Message "Failed to import function ${import}: $_"
    }

}

Export-ModuleMember -Function $Public.BaseName
