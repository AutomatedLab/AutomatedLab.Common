@{
    RootModule             = 'AutomatedLab.Common.psm1'

    ModuleVersion          = '1.0.6'
    GUID                   = '554685d3-5c61-4080-afd6-1dd3d4d7a261'

    Author                 = 'Raimund Andree, Per Pedersen, Jan-Hendrik Peters'

    CompanyName            = 'AutomatedLab Team'

    Copyright              = '2017'

    Description            = 'The module collects all helper functions used in but not limited to AutomatedLab'

    PowerShellVersion      = '5.0'

    DotNetFrameworkVersion = '4.0'

    CLRVersion             = '4.0'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport      = @(
        'Add-AccountPrivilege',
        'Add-CATemplateStandardPermission',
        'Add-Certificate2',
        'Add-FunctionToPSSession',
        'Add-StringIncrement',
        'Add-VariableToPSSession',
        'ConvertTo-BinaryIP',
        'ConvertTo-DecimalIP',
        'ConvertTo-DottedDecimalIP',
        'ConvertTo-Mask',
        'ConvertTo-MaskLength',
        'Enable-AutoEnrollment',
        'Find-CertificateAuthority',
        'Get-BroadcastAddress',
        'Get-CATemplate',
        'Get-Certificate2',
        'Get-ConsoleText',
        'Get-DscConfigurationImportedResource',
        'Get-FullMesh',
        'Get-NetworkAddress',
        'Get-NetworkRange',
        'Get-NetworkSummary',
        'Get-NextOid',
        'Get-PublicIpAddress',
        'Get-StringSection',
        'Get-Type',
        'Install-SoftwarePackage',
        'Invoke-Ternary',
        'New-CATemplate',
        'Publish-CATemplate',
        'Request-Certificate',
        'Send-ModuleToPSSession',
        'Sync-Parameter',
        'Test-CATemplate',
        'Test-HashtableKeys',
        'Test-IsAdministrator',
        'Test-Port'
    )

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
            Tags       = @(
                'Lab Automation'
                'AutomatedLab'
                'Networking'
                'PKI'
                'Desired State Configuration'
                'DSC'
            )

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/AutomatedLab/AutomatedLab.Common/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/AutomatedLab/AutomatedLab.Common/'

            # A URL to an icon representing this module.
            IconUri    = 'https://raw.githubusercontent.com/AutomatedLab/AutomatedLab/develop/Automated-Lab_icon256.png'

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable
}
