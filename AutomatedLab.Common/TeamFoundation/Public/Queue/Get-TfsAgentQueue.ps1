function Get-TfsAgentQueue
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
        $ApiVersion = '3.0-preview',

        [Parameter(Mandatory)]
        [string]
        $ProjectName,

        [string]
        $QueueName,

        [Parameter(Mandatory, ParameterSetName = 'Cred')]
        [pscredential]
        $Credential,

        [Parameter(Mandatory, ParameterSetName = 'Pat')]
        [string]
        $UserName,
        
        [Parameter(Mandatory, ParameterSetName = 'Pat')]
        [string]
        $PersonalAccessToken
    )

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += '{0}/{1}/{2}/_apis/distributedtask/queues?api-version={3}' -f $InstanceName, $CollectionName, $ProjectName, $ApiVersion

    if ( $Port )
    {
        $requestUrl += '{0}{1}/{2}/{3}/_apis/distributedtask/queues?api-version={4}' -f $InstanceName, ":$Port", $CollectionName, $ProjectName, $ApiVersion
    }

    if ($Name)
    {
        $requestUrl += '&queueName={0}' -f $Name
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
        $requestParameters.Headers = @{ Authorization = Get-TfsAccessTokenString -UserName $UserName -PersonalAccessToken $PersonalAccessToken }
    }

    try
    {
        $result = Invoke-WebRequest @requestParameters
    }
    catch
    {
        return $null
    }
    
    return $result.Content | ConvertFrom-Json
}
