function Remove-TfsAgentUserCapability
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
        $PoolName = '*',

        [Parameter(Mandatory, ParameterSetName = 'CredId')]
        [Parameter(Mandatory, ParameterSetName = 'PatId')]
        [uint16]
        $AgentId,

        [Parameter(Mandatory, ParameterSetName = 'CredObject')]
        [Parameter(Mandatory, ParameterSetName = 'PatObject')]
        [object]
        $Agent,

        [ValidateRange(1, 65535)]
        [uint32]
        $Port,

        [string]
        $ApiVersion = '5.1',

        [switch]
        $UseSsl,

        [Parameter(Mandatory, ParameterSetName = 'CredId')]
        [Parameter(Mandatory, ParameterSetName = 'CredObject')]
        [pscredential]
        $Credential,
        
        [Parameter(Mandatory, ParameterSetName = 'PatId')]
        [Parameter(Mandatory, ParameterSetName = 'PatObject')]
        [string]
        $PersonalAccessToken,

        [switch]
        $SkipCertificateCheck,

        [Parameter(Mandatory)]
        [string[]]
        $Capability
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

    if ($AgentId)
    {
        $agtParam = Sync-Parameter -Command (Get-Command Get-TfsAgent) -Parameter $PSBoundParameters
        $Agent = Get-TfsAgent @agtParam -Filter {$_.id -eq $AgentId}
    }

    if (-not $Agent)
    {
        Write-Error -Message "Agent could not be found!"
        return
    }

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ( $Port  -gt 0)
    {
        '{0}{1}/{2}/_apis/distributedtask/pools/{3}/agents/{4}/usercapabilities' -f $InstanceName, ":$Port", $CollectionName, $pool.id, $Agent.Id
    }
    else
    {
        '{0}/{1}/_apis/distributedtask/pools/{2}/agents/{3}/usercapabilities' -f $InstanceName, $CollectionName, $pool.id, $Agent.Id
    }
    
    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
    }

    $settableCapabilities = @{ }
    foreach ($prop in $Agent.usercapabilities.psobject.properties)
    {
        if ($prop.Name -in $Capability) { continue }
        $settableCapabilities[$prop.Name] = $prop.Value
    }

    $requestParameters = @{
        Uri             = $requestUrl
        Method          = 'Put'
        ContentType     = 'application/json'
        Body            = ($settableCapabilities | ConvertTo-Json)
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
        return $result.value
    }
    elseif ($result)
    {
        return $result
    }
}
