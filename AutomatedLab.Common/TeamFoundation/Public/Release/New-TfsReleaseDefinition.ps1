function New-TfsReleaseDefinition
{
    [CmdletBinding(DefaultParameterSetName = 'Cred')]
    param
    (
        [Parameter(Mandatory)]
        [string]
        $InstanceName,

        [Parameter()]
        [string]
        $CollectionName = 'DefaultCollection',

        [ValidateRange(1, 65535)]
        [uint32]
        $Port,

        [string]
        $ApiVersion = '3.0-preview.3',

        [Parameter(Mandatory)]
        [string]
        $ProjectName,

        [Parameter(Mandatory)]
        [string]
        $ReleaseName,

        [hashtable[]]
        $ReleaseTasks,

        [switch]
        $UseSsl,

        [Parameter(Mandatory, ParameterSetName = 'Cred')]
        [pscredential]
        $Credential,
        
        [Parameter(Mandatory, ParameterSetName = 'Pat')]
        [string]
        $PersonalAccessToken
    )

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ( $Port -gt 0)
    {
        '{0}{1}/{2}/{3}/_apis/release/definitions' -f $InstanceName, ":$Port", $CollectionName, $ProjectName
    }
    else
    {
        '{0}/{1}/{2}/_apis/release/definitions' -f $InstanceName, $CollectionName, $ProjectName
    }

    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
    }

    $exReleaseParam = Sync-Parameter -Command (Get-Command Get-TfsReleaseDefinition) -Parameters $PSBoundParameters
    $exReleaseParam.Remove('Version')
    $existingRelease = Get-TfsReleaseDefinition @exReleaseParam
    if ($existingRelease) { return }

    $qparameters = Sync-Parameter -Command (Get-Command Get-TfsAgentQueue) -Parameters $PSBoundParameters
    $qparameters.Remove('ApiVersion') # preview-API is called
    $qparameters.ErrorAction = 'SilentlyContinue'
    $queue = Get-TfsAgentQueue @qparameters | Select-Object -First 1

    if (-not $queue)
    {
        $parameters = Sync-Parameter -Command (Get-Command New-TfsAgentQueue) -Parameters $PSBoundParameters
        $parameters.Remove('ApiVersion') # preview-API is called
        $parameters.ErrorAction = 'Stop'
        $qparameters.ErrorAction = 'Stop'
        try
        {
            New-TfsAgentQueue @parameters
            $queue = Get-TfsAgentQueue @qparameters | Select-Object -First 1
        }
        catch
        {
            Write-Error -ErrorRecord $_
        }
    }

    $projectParameters = Sync-Parameter -Command (Get-Command Get-TfsProject) -Parameters $PSBoundParameters
    $projectParameters.ErrorAction = 'Stop'
    
    try
    {
        $project = Get-TfsProject @projectParameters
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }

    $buildParameters = Sync-Parameter -Command (Get-Command Get-TfsBuildDefinition) -Parameters $PSBoundParameters
    $buildParameters.ErrorAction = 'Stop'

    try
    {
        $build = Get-TfsBuildDefinition @buildParameters
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }

    $payload = @{
        "id"                = 0 
        "name"              = $ReleaseName
        "comment"           = $null 
        "createdOn"         = "2018-03-20T09:10:08.964Z" 
        "createdBy"         = $null 
        "modifiedBy"        = $null 
        "modifiedOn"        = $null 
        "environments"      = @(
            @{
                "id"                      = -656 
                "name"                    = "Environment" 
                "rank"                    = 1 
                "deployStep"              = @{
                    "id"    = 0 
                    "tasks" = @()
                } 
                "deployPhases"            = @(
                    @{
                        "name"            = "Run on agent" 
                        "phaseType"       = 1 
                        "rank"            = 1 
                        "workflowTasks"   = $ReleaseTasks
                        "deploymentInput" = @{
                            "demands"               = @() 
                            "queueId"               = 1 
                            "enableAccessToken"     = $false 
                            "skipArtifactsDownload" = $false 
                            "timeoutInMinutes"      = 0
                        } 
                        "controlOptions"  = @{
                            "alwaysRun"       = $false 
                            "continueOnError" = $false 
                            "enabled"         = $true
                        }
                    }
                ) 
                "queueId"                 = $queue.id 
                "demands"                 = @() 
                "conditions"              = @(
                    @{
                        "name"          = "ReleaseStarted" 
                        "conditionType" = 1 
                        "value"         = ""
                    }
                ) 
                "environmentOptions"      = @{
                    "emailNotificationType" = "OnlyOnFailure" 
                    "emailRecipients"       = "release.environment.owner;release.creator" 
                    "skipArtifactsDownload" = $false 
                    "timeoutInMinutes"      = 0 
                    "enableAccessToken"     = $false
                } 
                "executionPolicy"         = @{
                    "concurrencyCount" = 0 
                    "queueDepthCount"  = 0
                } 
                "releaseId"               = $null 
                "definitionEnvironmentId" = $null 
                "preDeployApprovals"      = @{
                    "approvals"       = @(
                        @{
                            "rank"             = 1 
                            "isAutomated"      = $true
                            "isNotificationOn" = $false 
                            "id"               = 0
                        }
                    ) 
                    "approvalOptions" = $null
                } 
                "postDeployApprovals"     = @{
                    "approvals"       = @(
                        @{
                            "rank"             = 1 
                            "isAutomated"      = $true 
                            "isNotificationOn" = $false 
                            "id"               = 0
                        }
                    ) 
                    "approvalOptions" = $null
                } 
                "schedules"               = @() 
                "retentionPolicy"         = @{
                    "daysToKeep"     = 30 
                    "releasesToKeep" = 3 
                    "retainBuild"    = $true
                }
            }
        ) 
        "artifacts"         = @(
            @{
                "id"                  = 0 
                "definitionReference" = @{
                    "project"    = @{
                        "id"   = $project.id
                        "name" = $project.name
                    } 
                    "definition" = @{
                        "id"   = $build.id
                        "name" = $build.name
                    }
                } 
                "alias"               = $build.name
                "type"                = "Build" 
                "artifactTypeName"    = "Build" 
                "sourceId"            = "" 
                "isPrimary"           = $true
            }
        )  
        "triggers"          = @(
            @{
                "triggerType"   = 1 
                "artifactAlias" = $build.name
            }
        ) 
        "releaseNameFormat" = 'Release-$(rev:r)'
    }

    $requestParameters = @{
        Uri         = $requestUrl
        Method      = 'Post'
        ContentType = 'application/json'
        Body        = ($payload | ConvertTo-Json -Depth 42)
        ErrorAction = 'Stop'
    }

    if ($Credential)
    {
        $requestParameters.Credential = $Credential
    }
    else
    {
        $requestParameters.Headers = @{ Authorization = Get-TfsAccessTokenString -PersonalAccessToken $PersonalAccessToken }
    }

    try
    {
        $result = Invoke-RestMethod @requestParameters
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }
}
