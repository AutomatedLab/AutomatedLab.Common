function Set-TfsFeedPermissions
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
        $ApiVersion = '2.0',

        [Parameter(Mandatory)]
        [string]
        $FeedName,

        [Parameter(Mandatory)]
        [object[]]
        $Permissions,

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
        
    $feedParameters = Sync-Parameter -Command (Get-Command -Name Get-TfsFeed) -Parameters $PSBoundParameters
    $feedParameters.ErrorAction = 'SilentlyContinue'
    $feed = Get-TfsFeed @feedParameters
    if (-not $feed)
    {
        Write-Error -Message "The Feed '$FeedName' does not exist"
        return
    }

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ( $Port -gt 0)
    {
        '{0}{1}/{2}/_apis/packaging/Feeds/{3}/permissions' -f $InstanceName, ":$Port", $CollectionName, $feed.id
    }
    else
    {
        '{0}/{1}/_apis/packaging/Feeds/{2}/permissions' -f $InstanceName, $CollectionName, $feed.id
    }
    
    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
    }

    $payload = @{
        body        = $Permissions
    }

    $requestParameters = @{
        Uri         = $requestUrl
        Method      = 'Patch'
        ContentType = 'application/json'
        Body        = ($Permissions | ConvertTo-Json)
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
        Write-Error -ErrorRecord $_
    }
}
