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

        [ValidateSet('1.0', '2.0')]
        [Version]
        $ApiVersion = '1.0',

        [switch]
        $UseSsl,

        [Parameter(Mandatory, ParameterSetName = 'Tfs')]
        [pscredential]
        $Credential,

        [Parameter(Mandatory, ParameterSetName = 'Vsts')]
        [string]
        $UserName,
        
        [Parameter(Mandatory, ParameterSetName = 'Vsts')]
        [string]
        $PersonalAccessToken
    )

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += '{0}/{1}/_apis/process/processes?api-version={2}' -f $InstanceName, $CollectionName, $ApiVersion.ToString(2)

    if ($Port -gt 0)
    {
        $requestUrl += '{0}{1}/{2}/_apis/process/processes?api-version={3}' -f $InstanceName, ":$Port", $CollectionName, $ApiVersion.ToString(2)
    }
    
    $parameters = @{
        Uri    = $requestUrl
        Method = 'Get'
    }

    if ( $Credential)
    {
        $parameters.Credential = $Credential
    }

    (Invoke-RestMethod @parameters).value
}
