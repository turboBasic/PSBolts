$projectRoot = Resolve-Path -Path $PSScriptRoot/..
$moduleRoot = Split-Path -Path (Resolve-Path -Path $projectRoot/*/*.psm1)
$moduleName = Split-Path -Path $moduleRoot -Leaf

Describe "General project validation: $moduleName" {

    $scripts = Get-ChildItem -Path $projectRoot -Include *.ps1,*.psm1,*.psd1 -Recurse

    # TestCases are splatted to the script so we need hashtables
    $testCase = $scripts | 
        Foreach-Object { 
            @{ file = $_ } 
        }

    It "Script <file> should be valid powershell" -TestCases $testCase {
        param( $file )

        $file.FullName | Should Exist

        $contents = Get-Content -Path $file.FullName -ErrorAction Stop
        $errors = $null
        [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors) | Out-Null
        $errors.Count | Should Be 0
    }

    It "Module '$moduleName' can be imported cleanly" {
        { Import-Module -Name (Join-Path -Path $moduleRoot -ChildPath "$moduleName.psm1") -Force } | Should Not Throw
    }
}
