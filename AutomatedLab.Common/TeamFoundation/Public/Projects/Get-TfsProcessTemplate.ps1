function Get-TfsProcessTemplate
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
        $ApiVersion = '1.0',

        [switch]
        $UseSsl,

        [Parameter(Mandatory, ParameterSetName = 'Tfs')]
        [pscredential]
        $Credential,
        
        [Parameter(Mandatory, ParameterSetName = 'Vsts')]
        [string]
        $PersonalAccessToken
    )

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ($Port -gt 0)
    {
        '{0}{1}/{2}/_apis/process/processes?api-version={3}' -f $InstanceName, ":$Port", $CollectionName, $ApiVersion
    }
    else
    {
        '{0}/{1}/_apis/process/processes?api-version={2}' -f $InstanceName, $CollectionName, $ApiVersion
    }
    
    $parameters = @{
        Uri    = $requestUrl
        Method = 'Get'
    }

    if ( $Credential)
    {
        $parameters.Credential = $Credential
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
        $PSCmdlet.ThrowTerminatingError($_)
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
