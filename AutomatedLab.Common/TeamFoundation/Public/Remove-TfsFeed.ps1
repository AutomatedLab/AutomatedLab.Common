function Remove-TfsFeed
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
 
        [Parameter(Mandatory)]
        [string]
        $FeedName,
 
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

    $feed = Get-TfsFeed @PSBoundParameters
    if (-not $feed)
    {
        Write-Warning "The feed '$FeedName' does not exist."
        return
    }
 
    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ($Port -gt 0)
    {
        '{0}{1}/{2}/_apis/packaging/feeds/{3}' -f $InstanceName, ":$Port", $CollectionName, $feed.id
    }
    else
    {
        '{0}/{1}/_apis/packaging/feeds/{2}' -f $InstanceName, $CollectionName, $feed.id
    }
    
    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
    }
 
    $requestParameters = @{
        Uri         = $requestUrl
        Method      = 'Delete'
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
     
    $data = if ($result.value)
    {
        $result.value
    }
    elseif ($result)
    {
        $result
    }

    if ($FeedName)
    {
        $data | Where-Object name -eq $FeedName
    }
    else
    {
        $data
    }
}
