@{
    RootModule             = 'AutomatedLab.Common.psm1'

    ModuleVersion          = '1.1.34'
    GUID                   = '554685d3-5c61-4080-afd6-1dd3d4d7a261'

    Author                 = 'Raimund Andree, Per Pedersen, Jan-Hendrik Peters'

    CompanyName            = 'AutomatedLab Team'

    Copyright              = '2019'

    Description            = 'The module collects all helper functions used in but not limited to AutomatedLab'

    PowerShellVersion      = '5.1'

    DotNetFrameworkVersion = '4.0'

    CLRVersion             = '4.0'

    CompatiblePSEditions   = @('Desktop','Core')

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
        'Get-DotNetFrameworkVersion',
        'Get-DscConfigurationImportedResource',
        'Get-FullMesh',
        'Get-NetworkAddress',
        'Get-NetworkRange',
        'Get-NetworkSummary',
        'Get-NextOid',
        'Get-PerformanceCounterID',
        'Get-PerformanceCounterLocalName',
        'Get-PerformanceDataCollectorSet',
        'Get-PublicIpAddress',
        'Get-RunspacePool',
        'Get-StringSection',
        'Get-TfsAccessTokenString',
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
        'New-CATemplate',
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
        'Request-Certificate',
        'Remove-TfsFeed',
        'Send-ModuleToPSSession',
        'Set-TfsProject',
        'Set-TfsFeedPermissions',
        'Split-Array',
        'Start-PerformanceDataCollectorSet',
        'Start-RunspaceJob',
        'Stop-PerformanceDataCollectorSet',
        'Sync-Parameter',
        'Test-CATemplate',
        'Test-HashtableKeys',
        'Test-IsAdministrator',
        'Test-Port',
        'Wait-RunspaceJob'
    )

    RequiredModules        = @('newtonsoft.json', 'PSFileTransfer')

    CmdletsToExport        = @()

    VariablesToExport      = @()

    AliasesToExport        = '??'

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
