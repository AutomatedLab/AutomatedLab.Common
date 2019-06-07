function New-TfsBuildDefinition
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
        $ApiVersion = '2.0',

        [Parameter(Mandatory)]
        [string]
        $ProjectName,

        [Parameter(Mandatory)]
        [string]
        $DefinitionName,

        [string]
        $QueueName,

        [hashtable[]]
        $BuildTasks, # Not very nice and needs to be replaced as soon as I find out how to retrieve all build step guids

        [hashtable[]]
        $Phases,

        [string[]]
        $CiTriggerRefs,

        [hashtable]
        $Variables,

        [switch]
        $UseSsl,

        [Parameter(Mandatory, ParameterSetName = 'Cred')]
        [pscredential]
        $Credential,
        
        [Parameter(Mandatory, ParameterSetName = 'Pat')]
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
    $requestUrl += if ($Port -gt 0)
    {
        '{0}{1}/{2}/{3}/_apis/build/definitions' -f $InstanceName, ":$Port", $CollectionName, $ProjectName
    }
    else
    {
        '{0}/{1}/{2}/_apis/build/definitions' -f $InstanceName, $CollectionName, $ProjectName
    }
    
    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
    }

    $exBuildParam = Sync-Parameter -Command (Get-Command Get-TfsBuildDefinition) -Parameters $PSBoundParameters
    $exBuildParam.Remove('Version')
    $existingBuild = Get-TfsBuildDefinition @exBuildParam
    if ($existingBuild | Where-Object name -eq $DefinitionName)
    { 
        Write-Verbose -Message ('Build definition {0} in {1} already exists.' -f $DefinitionName, $ProjectName);
        return 
    }

    $qparameters = Sync-Parameter -Command (Get-Command Get-TfsAgentQueue) -Parameters $PSBoundParameters
    $qparameters.Remove('ApiVersion') # preview-API is called
    $qparameters.ErrorAction = 'SilentlyContinue'
    $queue = Get-TfsAgentQueue @qparameters | Select-Object -First 1

    if (-not $queue)
    {
        Write-Verbose -Message ('No existing queue found for project {0}. Creating new queue.' -f $ProjectName)
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

    $repoParameters = Sync-Parameter -Command (Get-Command Get-TfsGitRepository) -Parameters $PSBoundParameters
    $repoParameters.ErrorAction = 'Stop'

    try
    {
        $repo = Get-TfsGitRepository @repoParameters
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }

    $buildDefinition = if ($ApiVersion -gt '4.0')
    {
        @{
            name       = $DefinitionName
            type       = "build"
            quality    = "definition"
            queue      = @{
                id = $queue.id
            }
            process      = @{ }
            repository = @{
                id            = $repo.id
                type          = "TfsGit"
                name          = $repo.name
                defaultBranch = "refs/heads/master"
                url           = $repo.remoteUrl
                clean         = $false
            }
            options    = @(
                @{
                    enabled    = $true
                    definition = @{
                        id = (New-Guid).Guid
                    }
                    inputs     = @{
                        parallel  = $false
                        multipliers = '["config","platform"]'
                    }
                }
            )
            variables  = @{
                forceClean = @{
                    value         = $false
                    allowOverride = $true
                }
                config     = @{
                    value         = "debug, release"
                    allowOverride = $true
                }
                platform   = @{
                    value         = "any cpu"
                    allowOverride = $true
                }
            }
        }
    }
    else
    {
        @{
            name       = $DefinitionName
            type       = "build"
            quality    = "definition"
            queue      = @{
                id = $queue.id
            }
            build      = $BuildTasks
            repository = @{
                id            = $repo.id
                type          = "TfsGit"
                name          = $repo.name
                defaultBranch = "refs/heads/master"
                url           = $repo.remoteUrl
                clean         = $false
            }
            options    = @(
                @{
                    enabled    = $true
                    definition = @{
                        id = (New-Guid).Guid
                    }
                    inputs     = @{
                        parallel  = $false
                        multipliers = '["config","platform"]'
                    }
                }
            )
            variables  = @{
                forceClean = @{
                    value         = $false
                    allowOverride = $true
                }
                config     = @{
                    value         = "debug, release"
                    allowOverride = $true
                }
                platform   = @{
                    value         = "any cpu"
                    allowOverride = $true
                }
            }
        }
    }

    if (-not $Phases -and $ApiVersion -ge '4.0')
    {
        $Phases =  @(
            @{
                name = 'Phase 1'
                condition = 'succeeded()'
            }
        )
        $buildDefinition.process.Add('phases', $Phases)

        if ($BuildTasks)
        {
            $buildDefinition.process.phases[0].Add('steps', $BuildTasks)
        }
    }

    $refs = @()
    if ($CiTriggerRefs)
    {
        foreach ($ref in $CiTriggerRefs)
        {
            $refs += "+$ref"
        }
        $trigger = @{
            branchFilters = $refs
            maxConcurrentBuildsPerBranch = 1
            pollingInterval = 0
            triggerType = 2
        }

        $buildDefinition.triggers = @($trigger)
    }

    if ($Variables)
    {
        foreach ($variable in $Variables.GetEnumerator())
        {
            $variableContent = @{
                value = $variable.Value
                allowOverrise = $true
            }
            $buildDefinition.variables.Add($variable.Key, $variableContent)
        }
    }

    $requestParameters = @{
        Uri         = $requestUrl
        Method      = 'Post'
        ContentType = 'application/json'
        Body        = ($buildDefinition | ConvertTo-Json -Depth 42)
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
        Write-Verbose -Message ('New build definition {0} created for project {1}' -f $DefinitionName, $ProjectName)
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }
}
