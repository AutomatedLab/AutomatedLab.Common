function Get-TfsProject
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
 
        [string]
        $ProjectName,
 
        [switch]
        $UseSsl,
 
        [Parameter(ParameterSetName = 'Tfs')]
        [pscredential]
        $Credential,
         
        [Parameter(ParameterSetName = 'Vsts')]
        [string]
        $PersonalAccessToken
    )
 
    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ( $Port -gt 0)
    {
        '{0}{1}/{2}/_apis/projects{4}?api-version={3}' -f $InstanceName, ":$Port", $CollectionName, $ApiVersion, "/$ProjectName"
    }
    else
    {
        '{0}/{1}/_apis/projects{3}?api-version={2}' -f $InstanceName, $CollectionName, $ApiVersion, "/$ProjectName"
    }
 
    $requestParameters = @{
        Uri         = $requestUrl
        Method      = 'Get'
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
