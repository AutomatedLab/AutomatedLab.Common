function New-TfsAgentQueue
{
    
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
        $ApiVersion = '3.0-preview.1',

        [Parameter(Mandatory = $true)]
        [string]
        $ProjectName,

        [switch]
        $UseSsl,

        [string]
        $QueueName,

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

    $existingQueue = Get-TfsAgentQueue @PSBoundParameters
    if ($existingQueue) { return $existingQueue }
    
    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ( $Port -gt 0)
    {
        '{0}{1}/{2}/{3}/_apis/distributedTask/queues' -f $InstanceName, ":$Port", $CollectionName, $ProjectName
    }
    else
    {
        '{0}/{1}/{2}/_apis/distributedTask/queues' -f $InstanceName, $CollectionName, $ProjectName
    }
    
    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
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
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }
}
