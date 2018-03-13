function New-TfsBuildDefinition
{
    [CmdletBinding(DefaultParameterSetName = 'Cred')]
    param
    (
        [Parameter(Mandatory)]
        [string]
        $InstanceName,

        [Parameter(Mandatory)]
        [string]
        $CollectionName,

        [ValidateRange(1, 65535)]
        [uint32]
        $Port,

        [ValidateSet('1.0', '2.0')]
        [Version]
        $ApiVersion = '2.0',

        [Parameter(Mandatory)]
        [string]
        $ProjectName,

        [Parameter(Mandatory)]
        [string]
        $DefinitionName,

        [string]
        $QueueName,

        [switch]
        $UseSsl,

        [Parameter(Mandatory, ParameterSetName = 'Cred')]
        [pscredential]
        $Credential,

        [Parameter(Mandatory, ParameterSetName = 'Pat')]
        [string]
        $UserName,
        
        [Parameter(Mandatory, ParameterSetName = 'Pat')]
        [string]
        $PersonalAccessToken
    )

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += '{0}/{1}/_apis/build/definitions?api-version={2}' -f $InstanceName, $CollectionName, $ApiVersion.ToString(2)

    if ( $Port )
    {
        $requestUrl += '{0}{1}/{2}/_apis/build/definitions?api-version={3}' -f $InstanceName, ":$Port", $CollectionName, $ApiVersion.ToString(2)
    }

    if ( $QueueName )
    {
        $parameters = Sync-Parameter -Command (Get-Command Get-TfsAgentQueue) -Parameters $PSBoundParameters
        $parameters.Remove('ApiVersion') # preview-API is called
        $queue = Get-TfsAgentQueue @parameters

        if (-not $queue)
        {
            $parameters = Sync-Parameter -Command (Get-Command New-TfsAgentQueue) -Parameters $PSBoundParameters
            $parameters.Remove('ApiVersion') # preview-API is called
            New-TfsAgentQueue @parameters
        }
    }
    else
    {
        $queue = Get-TfsAgentQueue | Select-Object -First 1
    }

    $buildDefinition = @{
        "name"       = $DefinitionName
        "type"       = "build"
        "quality"    = "definition"
        "queue"      = @{
            "id" = $queue.id
        }
        "build"      = @(
            @{
                "enabled"         = true
                "continueOnError" = false
                "alwaysRun"       = false
                "displayName"     = "Build solution **\\*.sln"
                "task"            = @{
                    "id"          = "71a9a2d3-a98a-4caa-96ab-affca411ecda"
                    "versionSpec" = "*"
                }
                "inputs"          = @{
                    "solution"              = "**\\*.sln"
                    "msbuildArgs"           = ""
                    "platform"              = "$(platform)"
                    "configuration"         = "$(config)"
                    "clean"                 = "false"
                    "restoreNugetPackages"  = "true"
                    "vsLocationMethod"      = "version"
                    "vsVersion"             = "latest"
                    "vsLocation"            = ""
                    "msbuildLocationMethod" = "version"
                    "msbuildVersion"        = "latest"
                    "msbuildArchitecture"   = "x86"
                    "msbuildLocation"       = ""
                    "logProjectEvents"      = "true"
                }
            }
            @{
                "enabled"         = true
                "continueOnError" = false
                "alwaysRun"       = false
                "displayName"     = "Test Assemblies **\\*test*.dll;-:**\\obj\\**"
                "task"            = @{
                    "id"          = "ef087383-ee5e-42c7-9a53-ab56c98420f9"
                    "versionSpec" = "*"
                }
                "inputs"          = @{
                    "testAssembly"             = "**\\*test*.dll;-:**\\obj\\**"
                    "testFiltercriteria"       = ""
                    "runSettingsFile"          = ""
                    "codeCoverageEnabled"      = "true"
                    "otherConsoleOptions"      = ""
                    "vsTestVersion"            = "14.0"
                    "pathtoCustomTestAdapters" = ""
                }
            }
        )
        "repository" = @{
            "id"            = "278d5cd2-584d-4b63-824a-2ba458937249"
            "type"          = "tfsgit"
            "name"          = "Fabrikam-Fiber-Git"
            "localPath"     = "$(sys.sourceFolder)/MyGitProject"
            "defaultBranch" = "refs/heads/master"
            "url"           = "https://fabrikam-fiber-inc.visualstudio.com/DefaultCollection/_git/Fabrikam-Fiber-Git"
            "clean"         = "false"
        }
        "options"    = @(
            @{
                "enabled"    = true
                "definition" = @{
                    "id" = "7c555368-ca64-4199-add6-9ebaf0b0137d"
                }
                "inputs"     = @{
                    "parallel" = "false"
                }
            }
        )
        "variables"  = @{
            "forceClean" = @{
                "value"         = "false"
                "allowOverride" = true
            }
            "config"     = @{
                "value"         = "debug, release"
                "allowOverride" = true
            }
            "platform"   = @{
                "value"         = "any cpu"
                "allowOverride" = true
            }
        }
        "triggers"   = @()
        "comment"    = "my first definition"
    }
}