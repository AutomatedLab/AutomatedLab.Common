@{
    RootModule             = 'AutomatedLab.Common.psm1'
    ModuleVersion          = '1.0.0.0'
    GUID                   = '554685d3-5c61-4080-afd6-1dd3d4d7a261'

    Author                 = 'Raimund Andree, Per Pedersen, Jan-Hendrik Peters'

    CompanyName            = 'AutomatedLab Team'

    Copyright              = '2017'

    Description            = 'The module collects all helper functions used in but not limited to AutomatedLab'

    PowerShellVersion      = '5.0'

    DotNetFrameworkVersion = '4.0'

    CLRVersion             = '4.0'

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    NestedModules          = @(
        'AutomatedLab.Common.DscHelper.psm1', 
        'AutomatedLab.Common.NetworkHelper.psm1', 
        'AutomatedLab.Common.PkiHelper.psm1')

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport      = '*'

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport        = '*'

    # Variables to export from this module
    VariablesToExport      = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport        = '??'

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData            = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()

            # A URL to the license for this module.
            # LicenseUri = ''

            # A URL to the main website for this project.
            # ProjectUri = ''

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable
}

