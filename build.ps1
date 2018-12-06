param(
    $Task = 'Default'
)

# Grab nuget bits, install modules, set build variables, start build.
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

Install-Module -Name psake, PSDeploy, BuildHelpers, Pester -Scope CurrentUser  # -Force
# Install-Module -Name PoshRSJob -Scope CurrentUser

Set-BuildEnvironment

Invoke-psake -BuildFile ./psake.ps1 -TaskList $Task -NoLogo
exit ( [int]( -not $psake.build_success ) )
