@{
    RootModule             = 'AutomatedLab.Common.psm1'

    ModuleVersion          = '1.1.34'
    GUID                   = '554685d3-5c61-4080-afd6-1dd3d4d7a261'

    Author                 = 'Raimund Andree, Per Pedersen, Jan-Hendrik Peters'

    CompanyName            = 'AutomatedLab Team'

    Copyright              = '2017'

    Description            = 'The module collects all helper functions used in but not limited to AutomatedLab'

    PowerShellVersion      = '5.0'

    DotNetFrameworkVersion = '4.0'

    CLRVersion             = '4.0'

    FunctionsToExport      = '*'

    RequiredModules        = @('newtonsoft.json')

    CmdletsToExport        = '*'

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
