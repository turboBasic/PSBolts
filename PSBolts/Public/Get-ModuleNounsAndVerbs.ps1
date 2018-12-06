function Get-ModuleNounsAndVerbs {
    <#

        .SYNOPSIS
Gets list of cmdlet & function nouns in a module, each noun is complemented with the list of cmdlet verbs

        .DESCRIPTION
Helps to understand internal logic of a module by summarizing its cmdlets by used nouns.
Cmdlet gets sorted list of unique cmdlet & function nouns in a module, and complement each one with the list of verbs implemented in a module

        .INPUTS
[System.String[]]

        .OUTPUTS
[System.psCustomObject[]]

        .PARAMETER Name
The name(s) of module(s) where Get-ModuleNounsAndVerbs gets list of nouns and verbs from.
The module should be reachable from current Powershell session, ie. the module exists in `Get-Module *` command output.

        .EXAMPLE
Get-ModuleNounsAndVerbs -module DISM

        .EXAMPLE
Get-ModuleNounsAndVerbs -module PackageManagement, PowershellGet

        .EXAMPLE
Get-ModuleNounsAndVerbs -module DISM | Tee-Object -variable result
$result | Format-Table | Out-String | Set-Clipboard

        .NOTES
(c) 2017 turboBasic https://github.com/turboBasic/PSBolts

        .LINK
https://github.com/turboBasic/PSBolts

    #>

    #region function arguments

    [CmdletBinding(
        SupportsShouldProcess,
        ConfirmImpact = 'Low' )]
    [OutputType( [Object[]] )]

    param(
        [Parameter(
            Mandatory,
            Position = 0,
            HelpMessage = 'Enter the module name to fetch commands from',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateScript( {
                [Boolean] $(
                    try {
                        Get-Module -Name $_
                    }
                    catch {
                        $False
                    }
                )
            })]
        [Alias( 'moduleName')]
        [String[]] $Name,

        [Switch] $Force
    )

    #endregion


    BEGIN {
        if (-not $psBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $psCmdlet.SessionState.psVariable.GetValue('ConfirmPreference')
        }
        else {
            if ($psBoundParameters.Item('Confirm') -eq $False) {
                $allConfirmed = $True
            }
            else {
                $allConfirmed = $False
            }
        }
        if (-not $psBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $psCmdlet.SessionState.psVariable.GetValue('WhatIfPreference')
        }
        if (-not $psBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $psCmdlet.SessionState.psVariable.GetValue('VerbosePreference')
        }
        if (-not $psBoundParameters.ContainsKey('Debug')) {
            $DebugPreference = $psCmdlet.SessionState.psVariable.GetValue('DebugPreference')
        }
    }

    PROCESS {
        foreach ($aModule in $Name) {
            if (-not $allConfirmed -and
                -not $psCmdlet.ShouldProcess($Name, 'Get all nouns and verbs from Powershell module')
            ) {
                continue
            }

            "Get list of cmdlets from module $aModule" | Write-Verbose

            Get-Command -Module $aModule -CommandType Cmdlet, Function |
                Group-Object -Property Noun |
                ForEach-Object {
                [PSCustomObject] @{
                    Module = $aModule
                    Noun   = $_.Name
                    Verb   = [Array] $_.Group.Verb
                }
            }
        }
    }

    END {}

}
