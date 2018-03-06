function Sync-Parameter
{
    [Cmdletbinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript( {
                $_ -is [System.Management.Automation.FunctionInfo] -or $_ -is [System.Management.Automation.CmdletInfo] -or $_ -is [System.Management.Automation.ExternalScriptInfo]
            })]
        [object]$Command,
        
        [hashtable]$Parameters
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
    
    if ($PSBoundParameters.ContainsKey('Parameters'))
    {
        $Parameters
    }
    else
    {
        $global:ALBoundParameters = $Parameters
    }
}
