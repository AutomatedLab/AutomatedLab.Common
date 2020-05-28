function Get-TfsAgent
{
    param
    (
        [Parameter(Mandatory)]
        [string]
        $InstanceName,

        [Parameter()]
        [string]
        $CollectionName = 'DefaultCollection',

        [Parameter(Mandatory)]
        [string]
        $PoolName,

        [ValidateRange(1, 65535)]
        [uint32]
        $Port,

        [string]
        $ApiVersion,

        [switch]
        $UseSsl,

        [Parameter(Mandatory, ParameterSetName = 'Cred')]
        [pscredential]
        $Credential,
        
        [Parameter(Mandatory, ParameterSetName = 'Pat')]
        [string]
        $PersonalAccessToken,

        [switch]
        $SkipCertificateCheck,

        [scriptblock]
        $Filter = { $true }
    )

    if ($SkipCertificateCheck.IsPresent)
    {
        $null = [ServerCertificateValidationCallback]::Ignore()
    }

    $poolParam = Sync-Parameter -Command (Get-Command Get-TfsAgentPool) -Parameter $PSBoundParameters
    $pool = Get-TfsAgentPool @poolParam

    if (-not $pool)
    {
        Write-Error -Message "Pool $PoolName could not be found!"
        return
    }

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ( $Port  -gt 0)
    {
        '{0}{1}/{2}/_apis/distributedtask/pools/{3}/agents?includeCapabilities=true' -f $InstanceName, ":$Port", $CollectionName, $pool.id
    }
    else
    {
        '{0}/{1}/_apis/distributedtask/pools/{2}/agents?includeCapabilities=true' -f $InstanceName, $CollectionName, $pool.id
    }
    
    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
    }

    $requestParameters = @{
        Uri             = $requestUrl
        Method          = 'Get'
        ErrorAction     = 'Stop'
        UseBasicParsing = $true
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
    
    if ($result.value)
    {
        return $result.value | Where-Object -FilterScript $Filter
    }
    elseif ($result)
    {
        return $result | Where-Object -FilterScript $Filter
    }
}
