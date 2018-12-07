#
# Module manifest for module 'PSBolts'
#
# Generated by: Andriy Melnyk
#
# Generated on: 12/6/18
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSBolts.psm1'

# Version number of this module.
ModuleVersion = '0.2.3.66'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '2e399037-508a-4b8e-8e6a-69cf53529955'

# Author of this module
Author = 'Andriy Melnyk'

# Company or vendor of this module
CompanyName = 'Cargonautica'

# Copyright statement for this module
Copyright = '(c) Andriy Melnyk. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Everyday utilities wrapped in a Powershell module'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @('Get-ModuleNounsAndVerbs','Invoke-MultipartFormDataUpload','New-TimestampMessage')

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'productivity', 'text', 'utilities'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/turboBasic/PSBolts/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/turboBasic/PSBolts'

        # A URL to an icon representing this module.
        IconUri = 'https://gist.githubusercontent.com/TurboBasic/9dfd228781a46c7b7076ec56bc40d5ab/raw/03942052ba28c4dc483efcd0ebf4bfc6809ed0d0/hexagram3D.png'

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/turboBasic/PSBolts/blob/master/CHANGELOG.md'

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

