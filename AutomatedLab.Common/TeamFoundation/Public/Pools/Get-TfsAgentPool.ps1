function Get-TfsAgentPool
{
    param
    (
        [Parameter(Mandatory)]
        [string]
        $InstanceName,

        [ValidateRange(1, 65535)]
        [uint32]
        $Port,

        [string]
        $ApiVersion = '2.3-preview.1',

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
    $requestUrl += if ( $Port  -gt 0)
    {
        '{0}{1}/_apis/distributedtask/pools' -f $InstanceName, ":$Port"
    }
    else
    {
        '{0}/_apis/distributedtask/pools' -f $InstanceName
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
