function New-TfsFeed
{
    [CmdletBinding(DefaultParameterSetName = 'NameCred', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param
    (
        [Parameter(Mandatory = $true)]
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

        [Parameter(Mandatory = $true)]
        [string]
        $FeedName,

        [string]
        $Description,

        [switch]
        $UseSsl,

        [Parameter(Mandatory = $true, ParameterSetName = 'GuidCred')]
        [Parameter(Mandatory = $true, ParameterSetName = 'NameCred')]
        [pscredential]
        $Credential,

        [Parameter(Mandatory = $true, ParameterSetName = 'NamePat')]
        [Parameter(Mandatory = $true, ParameterSetName = 'GuidPat')]
        [string]
        $PersonalAccessToken,

        [timespan]
        $Timeout = (New-TimeSpan -Seconds 30),

        [switch]
        $SkipCertificateCheck
    )

    if (-not $PSCmdlet.ShouldProcess($FeedName, "New feed")) { return }

    if ($SkipCertificateCheck.IsPresent)
    {
        $null = [ServerCertificateValidationCallback]::Ignore()
    }

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ( $Port -gt 0)
    {
        '{0}{1}/{2}/_apis/packaging/feeds' -f $InstanceName, ":$Port", $CollectionName
    }
    else
    {
        '{0}/{1}/_apis/packaging/feeds' -f $InstanceName, $CollectionName
    }

    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
    }

    $feedParameters = Sync-Parameter -Command (Get-Command -Name Get-TfsFeed) -Parameters $PSBoundParameters
    $feedParameters.ErrorAction = 'SilentlyContinue'
    if (Get-TfsFeed @feedParameters)
    {
        Write-Error -Message "The Feed '$FeedName' already exists"
        return
    }

    $payload = @{
        name         = $FeedName
        description  = $Description
    }

    $requestParameters = @{
        Uri         = $requestUrl
        Method      = 'Post'
        ContentType = 'application/json'
        Body        = ($payload | ConvertTo-Json)
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
        $null = Invoke-RestMethod @requestParameters
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }
}
