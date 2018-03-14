function New-TfsProject
{
    [CmdletBinding(DefaultParameterSetName = 'NameCred')]
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
        $PersonalAccessToken
    )

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += '{0}/{1}/_apis/projects?api-version={2}' -f $InstanceName, $CollectionName, $ApiVersion.ToString(2)

    if ( $Port )
    {
        $requestUrl += '{0}{1}/{2}/_apis/projects?api-version={3}' -f $InstanceName, ":$Port", $CollectionName, $ApiVersion.ToString(2)
    }

    if ($PSCmdlet.ParameterSetName -like 'Name*')
    {
        $parameters = Sync-Parameter -Command (Get-Command Get-TfsProjectTemplate) -Parameters $PSBoundParameters
        $TemplateGuid = (Get-TfsProcessTemplate @parameters | Where-Object -Property name -eq $TemplateName).id
        if (-not $TemplateGuid) {throw "Could not locate $TemplateName. Try Get-TfsProjectTemplate to see all available templates"}
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

    if ($Credential)
    {
        $requestParameters.Credential = $Credential
    }
    else
    {
        $requestParameters.Headers = @{ Authorization = Get-TfsAccessTokenString -PersonalAccessToken $PersonalAccessToken }
    }

    $result = Invoke-RestMethod @requestParameters

    $projectParameters = Sync-Parameter -Command (Get-Command Get-TfsProject) -Parameters $PSBoundParameters
    $projectParameters.Project = $ProjectName
    while ((Get-TfsProject @projectParameters).State -ne 'wellFormed')
    {
        Start-Sleep -Seconds 1
    }
}
