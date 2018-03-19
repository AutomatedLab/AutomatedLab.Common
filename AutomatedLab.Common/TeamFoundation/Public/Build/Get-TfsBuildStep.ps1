function Get-TfsBuildStep
{
    [CmdletBinding(DefaultParameterSetName = 'Tfs')]
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

        [Parameter(Mandatory, ParameterSetName = 'TfsName')]
        [Parameter(Mandatory, ParameterSetName = 'VstsName')]
        [SupportsWildcards()]
        [string]
        $FriendlyName,

        [Parameter(Mandatory, ParameterSetName = 'TfsHashtable')]
        [Parameter(Mandatory, ParameterSetName = 'VstsHashtable')]
        [hashtable]
        $FilterHashtable,

        [Parameter(Mandatory, ParameterSetName = 'TfsScript')]
        [Parameter(Mandatory, ParameterSetName = 'VstsScript')]
        [scriptblock]
        $FilterScript,

        [switch]
        $UseSsl,

        [Parameter(Mandatory, ParameterSetName = 'Tfs')]
        [Parameter(Mandatory, ParameterSetName = 'TfsName')]
        [Parameter(Mandatory, ParameterSetName = 'TfsHashtable')]
        [Parameter(Mandatory, ParameterSetName = 'TfsScript')]
        [pscredential]
        $Credential,
        
        [Parameter(Mandatory, ParameterSetName = 'Vsts')]
        [Parameter(Mandatory, ParameterSetName = 'VstsName')]
        [Parameter(Mandatory, ParameterSetName = 'VstsHashtable')]
        [Parameter(Mandatory, ParameterSetName = 'VstsScript')]
        [string]
        $PersonalAccessToken
    )

    $requestUrl = if ($UseSsl) {'https://' } else {'http://'}
    $requestUrl += if ( $Port -gt 0)
    {
        '{0}{1}/{2}/_apis/distributedtask/tasks' -f $InstanceName, ":$Port", $CollectionName
    }
    else
    {
        '{0}/{1}/_apis/distributedtask/tasks' -f $InstanceName, $CollectionName
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
    
    $steps = if ($result.value)
    {
        $result.value
    }
    elseif ($result)
    {
        $result
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
