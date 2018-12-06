# PSake makes variables declared here available in other scriptblocks
Properties {
    # Init some things

    # Find the build folder based on build system
    $ProjectRoot = $ENV:BHProjectPath
    if (-not $ProjectRoot) {
        $ProjectRoot = $PSScriptRoot
    }

    $Timestamp = Get-Date -UFormat "%Y%m%d-%H%M%S"
    $PSVersion = $PSVersionTable.PSVersion.Major
    $TestFile = "TestResults_PS${PSVersion}_${TimeStamp}.xml"
    $lines = '-' * 70

    $Verbose = @{}
    if ($ENV:BHCommitMessage -match "!verbose") {
        $Verbose = @{ Verbose = $True }
    }
}

Task Default -Depends Deploy

Task Init {
    $lines
    Set-Location -Path $ProjectRoot
    'Build System Details:'
    Get-Item -Path ENV:BH* | Format-List
    "`n"
}

Task UnitTests -Depends Init {
    $lines
    'Running quick unit tests to fail early if there is an error'
    $TestResults = Invoke-Pester -Path ${ProjectRoot}/Tests/*unit* -PassThru # -Tag Build

    if ($TestResults.FailedCount -gt 0)
    {
        Write-Error -Message "Failed '$($TestResults.FailedCount)' tests, build failed"
    }
    "`n"
}

Task Test -Depends UnitTests {
    $lines
    "`n`tSTATUS: Testing with PowerShell $PSVersion"

    # Gather test results. Store them in a variable and file
    $pesterParameters = @{
        Path         = "${ProjectRoot}/Tests"
        PassThru     = $true
        OutputFormat = "NUnitXml" 
        OutputFile   = "${ProjectRoot}/${TestFile}"
    }
    $TestResults = Invoke-Pester @pesterParameters # -Tag Build
    #& "$ProjectRoot/Tests/Invoke-RSPester.ps1" -Path $ProjectRoot\Tests
    

    # Upload our tests to Appveyor tests' storage
    If ($ENV:BHBuildSystem -eq 'AppVeyor') {
        (New-Object 'System.Net.WebClient').UploadFile(
            "https://ci.appveyor.com/api/testresults/nunit/${ENV:APPVEYOR_JOB_ID}", (Resolve-Path -Path ${ProjectRoot}/${TestFile})
        )
    }
    Remove-Item -Path ${ProjectRoot}/${TestFile} -Force -ErrorAction SilentlyContinue



    # Failed tests?
    # Need to tell psake or it will proceed to the deployment. Danger!
    if ($TestResults.FailedCount -gt 0) {
        Write-Error "Failed '$($TestResults.FailedCount)' tests, build failed"
    }
    "`n"
}

Task Build -Depends Test {
    $lines

    $functions = Get-ChildItem -Path ${PSScriptRoot}/${ENV:BHProjectName}/Public/*.ps1 |
        Where-Object Name -NotMatch Tests |
        Select-Object -ExpandProperty BaseName


    # Load the module, read the exported functions, update the psd1 FunctionsToExport
    Set-ModuleFunctions -Name ${ENV:BHPSModuleManifest} -FunctionsToExport $functions

    # Bump the module version
    $version = [Version] (Step-Version (Get-Metadata -Path ${ENV:BHPSModuleManifest}))
    $galleryVersion = Get-NextPSGalleryVersion -Name ${ENV:BHProjectName}
    if ($version -lt $galleryVersion)
    {
        $version = $galleryVersion
    }
    $version = [Version]::New( $version.Major, $version.Minor, $version.Build, ${ENV:BHBuildNumber} )
    Write-Host "Using version: $version"

    Update-Metadata -Path ${ENV:BHPSModuleManifest} -PropertyName ModuleVersion -Value $version
}

Task Deploy -Depends Build {
    $lines

    # Gate deployment
    if (
        $ENV:BHBuildSystem -ne 'Unknown' -and
        $ENV:BHBranchName -eq "master" -and
        $ENV:BHCommitMessage -match '!deploy'
    )
    {
        $Params = @{
            Path  = $ProjectRoot
            Force = $true
        }

        Invoke-PSDeploy @Verbose @Params
    }
    else
    {
        "Skipping deployment: To deploy, ensure that...`n" +
        "`t* You are in a known build system (Current: ${ENV:BHBuildSystem})`n" +
        "`t* You are committing to the master branch (Current: ${ENV:BHBranchName}) `n" +
        "`t* Your commit message includes !deploy (Current: ${ENV:BHCommitMessage})"
    }
}
