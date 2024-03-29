function New-TfsReleaseDefinition
{
    [CmdletBinding(DefaultParameterSetName = 'Cred')]
    param
    (
        [Parameter(Mandatory = $true)]
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

        [Parameter(Mandatory = $true)]
        [string]
        $ProjectName,

        [Parameter(Mandatory = $true)]
        [string]
        $ReleaseName,

        [hashtable[]]
        $ReleaseTasks,

        [hashtable[]]
        $Environments,

        [switch]
        $UseSsl,

        [Parameter(Mandatory = $true, ParameterSetName = 'Cred')]
        [pscredential]
        $Credential,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'Pat')]
        [string]
        $PersonalAccessToken,

        [switch]
        $SkipCertificateCheck
    )

    if ($SkipCertificateCheck.IsPresent)
    {
        $null = [ServerCertificateValidationCallback]::Ignore()
    }

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
    $exReleaseParam.Remove('ApiVersion')
    $existingRelease = Get-TfsReleaseDefinition @exReleaseParam
    if ($existingRelease | Where-Object name -eq $ReleaseName)
    {
        Write-Verbose -Message ('Release definition {0} in {1} already exists.' -f $ReleaseName, $ProjectName);
        return 
    }

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

    if (-not $Environments)
    {
        $Environments = @(
            @{
                "id"                      = 1 
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
                            "queueId"               = $queue.id 
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
    }

    $payload = @{
        "id"                = 0 
        "name"              = $ReleaseName
        "comment"           = $null 
        "createdOn"         = (Get-Date).ToString('yyyy-MM-ddThh:mm:ss.fffZ')
        "createdBy"         = $null 
        "modifiedBy"        = $null 
        "modifiedOn"        = $null 
        "environments"      = $Environments
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

    if ($PSEdition -eq 'Core' -and (Get-Command -Name Invoke-RestMethod).Parameters.ContainsKey('SkipCertificateCheck'))
    {
        $requestParameters.SkipCertificateCheck = $SkipCertificateCheck.IsPresent
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
        Write-Verbose -Message ('New release definition {0} created for project {1}' -f $ReleaseName, $ProjectName)
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }
}
