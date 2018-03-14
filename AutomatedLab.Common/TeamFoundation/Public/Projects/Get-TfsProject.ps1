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

        [ValidateSet('1.0', '2.0')]
        [Version]
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
        $UserName,
        
        [Parameter(ParameterSetName = 'Vsts')]
        [string]
        $PersonalAccessToken
    )

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += '{0}/{1}/_apis/projects{3}?api-version={2}' -f $InstanceName, $CollectionName, $ApiVersion.ToString(2), "/$ProjectName"

    if ( $Port )
    {
        $requestUrl += '{0}{1}/{2}/_apis/projects{4}?api-version={3}' -f $InstanceName, ":$Port", $CollectionName, $ApiVersion.ToString(2), "/$ProjectName"
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

    try
    {
        $result = Invoke-RestMethod @requestParameters
    }
    catch
    {
        return $null
    }
    
    return $result.Content.value
}
