function New-TfsAgentQueue
{
    
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
        $ApiVersion = '3.0-preview.1',

        [Parameter(Mandatory)]
        [string]
        $ProjectName,

        [switch]
        $UseSsl,

        [string]
        $QueueName,

        [Parameter(Mandatory, ParameterSetName = 'Cred')]
        [pscredential]
        $Credential,
        
        [Parameter(Mandatory, ParameterSetName = 'Pat')]
        [string]
        $PersonalAccessToken
    )

    $existingQueue = Get-TfsAgentQueue @PSBoundParameters
    if ($existingQueue) { return $existingQueue }
    
    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ( $Port -gt 0)
    {
        '{0}{1}/{2}/{3}/_apis/distributedTask/queues?api-version={4}' -f $InstanceName, ":$Port", $CollectionName, $ProjectName, $ApiVersion
    }
    else
    {
        '{0}/{1}/{2}/_apis/distributedTask/queues?api-version={3}' -f $InstanceName, $CollectionName, $ProjectName, $ApiVersion
    }

    $poolParameter = Sync-Parameter -Command (Get-Command Get-TfsAgentPool) -Parameters $PSBoundParameters
    $pools = Get-TfsAgentPool @poolParameter

    $useablePool = $pools | Where-Object -Property size -gt 0 | Select-Object -First 1
    if (-not $useablePool) { $useablePool = $pools | Select-Object -First 1}
    if (-not $useablePool) { Write-Error -Message 'No agent pools available to form queue'; return}

    $payload = [ordered]@{
        "name" = $QueueName
        "pool" = @{
            "id" = $useablePool.id
        }
    }

    $requestParameters = @{
        Uri         = $requestUrl
        Method      = 'Post'
        ContentType = 'application/json'
        Body        = ($payload | ConvertTo-Json)
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
