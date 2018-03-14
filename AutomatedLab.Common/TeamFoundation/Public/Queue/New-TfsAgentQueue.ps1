function New-TfsAgentQueue
{
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

        [string]
        $ApiVersion = '3.0-preview.1',

        [Parameter(Mandatory)]
        [string]
        $ProjectName,

        [string]
        $QueueName,

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

    $existingQueue = Get-TfsAgentQueue @PSBoundParameters
    if ($existingQueue) { return $existingQueue }
    
    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += '{0}/{1}/{2}/_apis/distributedTask/queues?api-version={3}' -f $InstanceName, $CollectionName, $ProjectName, $ApiVersion

    if ( $Port )
    {
        $requestUrl += '{0}{1}/{2}/{3}/_apis/distributedTask/queues?api-version={4}' -f $InstanceName, ":$Port", $CollectionName, $ProjectName, $ApiVersion
    }

    $poolParameter = Sync-Parameter -Command (Get-Command Get-TfsAgentPool) -Parameters $PSBoundParameters
    $pools = Get-TfsAgentPool @poolParameter

    $useablePool = $pools | Where-Object -Property size -gt 0 | Select-Object -First 1
    if (-not $useablePool) { $useablePool = $pools | Select-Object -First 1}

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

    $result = Invoke-RestMethod @requestParameters
}
