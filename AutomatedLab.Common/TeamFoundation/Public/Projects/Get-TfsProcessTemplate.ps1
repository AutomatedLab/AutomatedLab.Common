function Get-TfsProcessTemplate
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
        '{0}{1}/{2}/_apis/process/processes' -f $InstanceName, ":$Port", $CollectionName
    }
    else
    {
        '{0}/{1}/_apis/process/processes' -f $InstanceName, $CollectionName
    }
    
    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
    }
    
    $requestParameters = @{
        Uri    = $requestUrl
        Method = 'Get'
    }

    if ( $Credential)
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
