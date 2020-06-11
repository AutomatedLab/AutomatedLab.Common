function Sync-Parameter
{
    [Cmdletbinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript( {
                $_ -is [System.Management.Automation.FunctionInfo] -or $_ -is [System.Management.Automation.CmdletInfo] -or $_ -is [System.Management.Automation.ExternalScriptInfo]
            })]
        [object]$Command,
        
        [hashtable]$Parameters,

        [switch]$ConvertValue
    )
    
    if (-not $PSBoundParameters.ContainsKey('Parameters'))
    {
        $Parameters = ([hashtable]$ALBoundParameters).Clone()
    }
    else
    {
        $Parameters = ([hashtable]$Parameters).Clone()
    }
    
    $commonParameters = [System.Management.Automation.Internal.CommonParameters].GetProperties().Name
    $commandParameterKeys = $Command.Parameters.Keys.GetEnumerator() | ForEach-Object { $_ }
    $parameterKeys = $Parameters.Keys.GetEnumerator() | ForEach-Object { $_ }
    
    $keysToRemove = Compare-Object -ReferenceObject $commandParameterKeys -DifferenceObject $parameterKeys |
        Select-Object -ExpandProperty InputObject

    $keysToRemove = $keysToRemove + $commonParameters | Select-Object -Unique #remove the common parameters
    
    foreach ($key in $keysToRemove)
    {
        $Parameters.Remove($key)
    }

    if ($ConvertValue.IsPresent)
    {
        $keysToUpdate = @{}
        foreach ($kvp in $Parameters.GetEnumerator())
        {
            if (-not $kvp.Value) # $null or empty string will not trip up conversion
            {
                continue
            }

            $targetType = $Command.Parameters[$kvp.Key].ParameterType
            $sourceType = $kvp.Value.GetType()
            $targetValue = $kvp.Value -as $targetType

            if (-not $targetValue -and $targetType.ImplementedInterfaces -contains [Collections.IList])
            {
                $targetValue = $targetType::new()
                foreach ($v in $kvp.Value)
                {
                    $targetValue.Add($v)
                }
            }

            if (-not $targetValue -and $targetType.ImplementedInterfaces -contains [Collections.IDictionary] )
            {
                $targetValue = $targetType::new()
                foreach ($k in $kvp.Value.GetEnumerator())
                {
                    $targetValue.Add($k.Key, $k.Value)
                }
            }

            if (-not $targetValue -and ($sourceType.ImplementedInterfaces -contains [Collections.IList] -and $targetType.ImplementedInterfaces -notcontains [Collections.IList]))
            {
                Write-Verbose -Message "Value of source parameter $($kvp.Key) is a collection, but target parameter is not. Selecting first object"
                $targetValue = $kvp.Value | Select-Object -First 1
            }

            if (-not $targetValue)
            {
                Write-Error -Message "Conversion of source parameter $($kvp.Key) (Type: $($sourceType.FullName)) to type $($targetType.FullName) was impossible"
                return
            }

            $keysToUpdate[$kvp.Key] = $targetValue
        }
    }

    if ($keysToUpdate)
    {
        foreach ($kvp in $keysToUpdate.GetEnumerator())
        {
            $Parameters[$kvp.Key] = $kvp.Value
        }
    }
    
    if ($PSBoundParameters.ContainsKey('Parameters'))
    {
        $Parameters
    }
    else
    {
        $global:ALBoundParameters = $Parameters
    }
}
