function Get-TfsGitRepository
{
    param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $InstanceName,

        [Parameter(Mandatory = $true)]
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
        $PersonalAccessToken,

        [switch]
        $SkipCertificateCheck
    )

    if ($SkipCertificateCheck.IsPresent)
    {
        $null = [ServerCertificateValidationCallback]::Ignore()
    }

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ( $Port -gt 0)
    {
        '{0}{1}/{2}/{3}/_apis/git/repositories' -f $InstanceName, ":$Port", $CollectionName, $ProjectName, $ApiVersion
    }
    else
    {
        '{0}/{1}/{2}/_apis/git/repositories' -f $InstanceName, $CollectionName, $ProjectName, $ApiVersion
    }

    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
    }

    $requestParameters = @{
        Uri         = $requestUrl
        Method      = 'Get'
        ErrorAction = 'Stop'
    }

    if ($PSEdition -eq 'Core' -and (Get-Command -Name Invoke-RestMethod).Parameters.ContainsKey('SkipCertificateCheck'))
    {
        $requestParameters.SkipCertificateCheck = $SkipCertificateCheck.IsPresent
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
        if ($_.ErrorDetails.Message)
        {
            $errorDetails = $_.ErrorDetails.Message | ConvertFrom-Json
            if ($errorDetails.typeKey -eq 'ProjectDoesNotExistWithNameException')
            {
                return $null
            }
        }

        Write-Error -ErrorRecord $_
    }

    return $result.value
}
