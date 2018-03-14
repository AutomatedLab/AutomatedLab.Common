function Get-TfsBuildDefinitionTemplate
{
    [CmdletBinding(DefaultParameterSetName = 'Cred')]
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

        [ValidateSet('1.0', '2.0')]
        [Version]
        $ApiVersion = '2.0',

        [Parameter(Mandatory)]
        [string]
        $ProjectName,

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
    $requestUrl += '{0}/{1}/{2}/_apis/build/definitions/templates?api-version={3}' -f $InstanceName, $CollectionName, $ProjectName, $ApiVersion.ToString(2)

    if ( $Port )
    {
        $requestUrl += '{0}{1}/{2}/{3}/_apis/build/definitions/templates?api-version={4}' -f $InstanceName, ":$Port", $CollectionName, $ProjectName, $ApiVersion.ToString(2)
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
