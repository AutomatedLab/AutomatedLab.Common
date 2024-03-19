@{
    RootModule             = 'AutomatedLab.Common.psm1'

    ModuleVersion          = '2.4.0'

    GUID                   = '554685d3-5c61-4080-afd6-1dd3d4d7a261'

    Author                 = 'Raimund Andree, Per Pedersen, Jan-Hendrik Peters'

    CompanyName            = 'AutomatedLab Team'

    Copyright              = '2019'

    Description            = 'The module collects all helper functions used in but not limited to AutomatedLab'

    PowerShellVersion      = '5.1'

    DotNetFrameworkVersion = '4.0'

    CLRVersion             = '4.0'

    CompatiblePSEditions   = @('Desktop', 'Core')

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport      = @(
        'Add-AccountPrivilege',
        'Add-CATemplateStandardPermission',
        'Add-Certificate2',
        'Add-FunctionToPSSession',
        'Add-StringIncrement',
        'Add-TfsAgentUserCapability',
        'Add-VariableToPSSession',
        'ConvertTo-BinaryIp',
        'ConvertTo-DecimalIp',
        'ConvertTo-DottedDecimalIp',
        'ConvertTo-Mask',
        'ConvertTo-MaskLength',
        'Enable-AutoEnrollment',
        'Find-CertificateAuthority',
        'Get-BroadcastAddress',
        'Get-CaTemplate',
        'Get-Certificate2',
        'Get-ConsoleText',
        'Get-DotNetFrameworkVersion',
        'Get-DscConfigurationImportedResource',
        'Get-FullMesh',
        'Get-NetworkAddress',
        'Get-NetworkRange',
        'Get-NetworkSummary',
        'Get-NextOid',
        'Get-ModuleDependency',
        'Get-PerformanceCounterID',
        'Get-PerformanceCounterLocalName',
        'Get-PerformanceDataCollectorSet',
        'Get-PublicIpAddress',
        'Get-RequiredModulesFromMOF',
        'Get-RunspacePool',
        'Get-StringSection',
        'Get-TfsAccessTokenString',
        'Get-TfsAgent',
        'Get-TfsAgentPool',
        'Get-TfsAgentQueue',
        'Get-TfsBuildDefinition',
        'Get-TfsBuildDefinitionTemplate',
        'Get-TfsBuildStep',
        'Get-TfsFeed',
        'Get-TfsFeedPermission',
        'Get-TfsGitRepository',
        'Get-TfsProcessTemplate',
        'Get-TfsProject',
        'Get-TfsReleaseDefinition',
        'Get-TfsReleaseStep',
        'Get-Type',
        'Install-SoftwarePackage',
        'Invoke-Ternary',
        'New-CaTemplate',
        'New-PerformanceDataCollectorSet',
        'New-RunspacePool',
        'New-TfsAgentQueue',
        'New-TfsBuildDefinition',
        'New-TfsFeed',
        'New-TfsProject',
        'New-TfsReleaseDefinition',
        'Publish-CaTemplate',
        'Read-Choice',
        'Read-HashTable',
        'Receive-RunspaceJob',
        'Remove-PerformanceDataCollectorSet',
        'Remove-RunspacePool',
        'Remove-TfsAgentUserCapability',
        'Remove-TfsFeed',
        'Request-Certificate',
        'Send-ModuleToPsSession',
        'Set-TfsAgentUserCapability',
        'Set-TfsFeedPermission',
        'Set-TfsProject',
        'Split-Array',
        'Start-PerformanceDataCollectorSet',
        'Start-RunspaceJob',
        'Stop-PerformanceDataCollectorSet',
        'Sync-Parameter',
        'Test-CaTemplate',
        'Test-HashtableKeys',
        'Test-IsAdministrator',
        'Test-Port',
        'Wait-RunspaceJob'
    )

    RequiredModules        = @('PSFileTransfer')

    CmdletsToExport        = @()

    VariablesToExport      = @()

    AliasesToExport        = '??', 'Set-TfsFeedPermissions'

    PrivateData            = @{

        PSData = @{

            Tags       = @(
                'LabAutomation'
                'AutomatedLab'
                'Networking'
                'PKI'
                'DesiredStateConfiguration'
                'DSC'
            )

            LicenseUri = 'https://github.com/AutomatedLab/AutomatedLab.Common/blob/master/LICENSE'

            ProjectUri = 'https://github.com/AutomatedLab/AutomatedLab.Common/'

            IconUri    = 'https://raw.githubusercontent.com/AutomatedLab/AutomatedLab/develop/Automated-Lab_icon256.png'

        }

    }
}
