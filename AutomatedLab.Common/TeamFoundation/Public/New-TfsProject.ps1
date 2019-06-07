function New-TfsProject
{
    
    [CmdletBinding(DefaultParameterSetName = 'NameCred')]
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
        $ProjectName,

        [string]
        $ProjectDescription,

        [ValidateSet('Git', 'Tfvc')]
        $SourceControlType = 'Git',

        [Parameter(Mandatory, ParameterSetName = 'GuidPat')]
        [Parameter(Mandatory, ParameterSetName = 'GuidCred')]
        [guid]
        $TemplateGuid,

        [Parameter(Mandatory, ParameterSetName = 'NamePat')]
        [Parameter(Mandatory, ParameterSetName = 'NameCred')]
        [string]
        $TemplateName,

        [switch]
        $UseSsl,

        [Parameter(Mandatory, ParameterSetName = 'GuidCred')]
        [Parameter(Mandatory, ParameterSetName = 'NameCred')]
        [pscredential]
        $Credential,
        
        [Parameter(Mandatory, ParameterSetName = 'NamePat')]
        [Parameter(Mandatory, ParameterSetName = 'GuidPat')]
        [string]
        $PersonalAccessToken,

        [timespan]
        $Timeout = (New-TimeSpan -Seconds 30),

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
        '{0}{1}/{2}/_apis/projects' -f $InstanceName, ":$Port", $CollectionName
    }
    else
    {
        '{0}/{1}/_apis/projects' -f $InstanceName, $CollectionName
    }
    
    if ($ApiVersion)
    {
        $requestUrl += '?api-version={0}' -f $ApiVersion
    }

    if ($PSCmdlet.ParameterSetName -like 'Name*')
    {
        $parameters = Sync-Parameter -Command (Get-Command Get-TfsProcessTemplate) -Parameters $PSBoundParameters
        $TemplateGuid = (Get-TfsProcessTemplate @parameters | Where-Object -Property name -eq $TemplateName).id
        if (-not $TemplateGuid) {Write-Error -Message "Could not locate $TemplateName. Try Get-TfsProcessTemplate to see all available templates"; return}
    }

    $projectParameters = Sync-Parameter -Command (Get-Command Get-TfsProject) -Parameters $PSBoundParameters
    $projectParameters.ErrorAction = 'SilentlyContinue'
    if (Get-TfsProject @projectParameters)
    {
        Write-Verbose -Message ('Project {0} already exists' -f $ProjectName)
        return
    }

    $payload = @{
        name         = $ProjectName
        description  = $ProjectDescription
        capabilities = @{
            versioncontrol  = @{
                sourceControlType = $SourceControlType                
            }
            processTemplate = @{
                templateTypeId = $TemplateGuid.Guid
            }
        }
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
        $result = Invoke-RestMethod @requestParameters
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }

    $start = Get-Date
    $projectStatus = Get-TfsProject @projectParameters

    while ($projectStatus.State -ne 'wellFormed' -and ((Get-Date) - $start -lt $Timeout))
    {
        Write-Verbose -Message ('Waiting {0} for {1} to enter status wellFormed' -f $Timeout, $ProjectName)
        Start-Sleep -Seconds 1
        $projectStatus = Get-TfsProject @projectParameters
    }

    if (-not $projectStatus.State -eq 'wellFormed')
    {
        Write-Error -Message ('Unable to create new project in {0}' -f $Timeout) -TargetObject $ProjectName
        return
    }

    return $projectStatus
}
