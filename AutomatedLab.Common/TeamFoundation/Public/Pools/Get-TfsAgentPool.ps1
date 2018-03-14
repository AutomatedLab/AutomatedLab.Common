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
    $requestUrl += '{0}/_apis/distributedtask/pools?api-version={1}' -f $InstanceName, $ApiVersion

    if ( $Port )
    {
        $requestUrl += '{0}{1}/_apis/distributedtask/pools?api-version={2}' -f $InstanceName, ":$Port", $ApiVersion
    }

    $requestParameters = @{
        Uri         = $requestUrl
        Method      = 'Get'
        ErrorAction = 'Stop'
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
        return $null
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
