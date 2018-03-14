function Get-TfsGitRepository
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
    $requestUrl += '{0}/{1}/{2}/_apis/git/repositories?api-version={3}' -f $InstanceName, $CollectionName, $ProjectName, $ApiVersion

    if ( $Port )
    {
        $requestUrl += '{0}{1}/{2}/{3}/_apis/git/repositories?api-version={4}' -f $InstanceName, ":$Port", $CollectionName, $ProjectName, $ApiVersion
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
