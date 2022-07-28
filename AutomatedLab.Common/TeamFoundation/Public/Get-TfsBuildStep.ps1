function Get-TfsBuildStep
{
    [CmdletBinding(DefaultParameterSetName = 'Tfs')]
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

        [Parameter(Mandatory = $true, ParameterSetName = 'TfsName')]
        [Parameter(Mandatory = $true, ParameterSetName = 'VstsName')]
        [SupportsWildcards()]
        [string]
        $FriendlyName,

        [Parameter(Mandatory = $true, ParameterSetName = 'TfsHashtable')]
        [Parameter(Mandatory = $true, ParameterSetName = 'VstsHashtable')]
        [hashtable]
        $FilterHashtable,

        [Parameter(Mandatory = $true, ParameterSetName = 'TfsScript')]
        [Parameter(Mandatory = $true, ParameterSetName = 'VstsScript')]
        [scriptblock]
        $FilterScript,

        [switch]
        $UseSsl,

        [Parameter(Mandatory = $true, ParameterSetName = 'Tfs')]
        [Parameter(Mandatory = $true, ParameterSetName = 'TfsName')]
        [Parameter(Mandatory = $true, ParameterSetName = 'TfsHashtable')]
        [Parameter(Mandatory = $true, ParameterSetName = 'TfsScript')]
        [pscredential]
        $Credential,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'Vsts')]
        [Parameter(Mandatory = $true, ParameterSetName = 'VstsName')]
        [Parameter(Mandatory = $true, ParameterSetName = 'VstsHashtable')]
        [Parameter(Mandatory = $true, ParameterSetName = 'VstsScript')]
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
        '{0}{1}/_apis/distributedtask/tasks' -f $InstanceName, ":$Port", $CollectionName
    }
    else
    {
        '{0}/_apis/distributedtask/tasks' -f $InstanceName, $CollectionName
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
        $result = Invoke-RestMethod @requestParameters -UseBasicParsing
    }
    catch
    {
        Write-Error -ErrorRecord $_
    }
    
    $steps = if ($result.value)
    {
        $result.value
    }
    elseif ($result)
    {
        ($result | ConvertFrom-JsonNewtonsoft).Value
    }

    if ($FriendlyName)
    {
        $steps = if ($FriendlyName -match '(\?|\*)')
        {
            $steps | Where-Object -Property friendlyName -like $FriendlyName
        }
        else
        {
            $steps | Where-Object -Property friendlyName -eq $FriendlyName
        }
    }

    if ($FilterHashtable)
    {
        $steps = foreach ( $kvp in $FilterHashtable.GetEnumerator())
        {
            if ($kvp.Value -match '(\?|\*)')
            {
                $steps | Where-Object -Property $kvp.Key -like $kvp.Value
            }
            else
            {
                $steps | Where-Object -Property $kvp.Key -eq $kvp.Value    
            }            
        }
    }

    if ($FilterScript)
    {
        $steps = $steps | Where-Object -FilterScript $FilterScript
    }

    '@('
    foreach ($step in $steps)
    {
        "
        @{
            enabled         = $true
            continueOnError = $false
            alwaysRun       = $false
            displayName     = 'YOUR OWN DISPLAY NAME HERE' # e.g. $($step.instanceNameFormat) or $($step.friendlyName)
            task            = @{
                id          = '$($step.id)'
                versionSpec = '*'
            }
            inputs          = @{"
        foreach ($input in $step.inputs)
        {
            $required = if ($input.required) {$true}else {$false}
            "`t`t`t`t{0} = 'VALUE' # Type: {1}, Default: {2}, Mandatory: {3}" -f $input.name, $input.type, $input.defaultValue, $required
        }
        '
            }
        }
        '
    }
    ')'
}
