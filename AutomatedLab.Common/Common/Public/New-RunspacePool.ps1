function New-RunspacePool
{
    [OutputType([System.Management.Automation.Runspaces.RunspacePool])]
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [int]
        $ThrottleLimit = 10,

        [Parameter()]
        [System.Threading.ApartmentState]
        $ApartmentState = 'Unknown',

        [Parameter()]
        [System.Management.Automation.PSVariable[]]
        $Variable,

        [Parameter()]
        [System.Management.Automation.FunctionInfo[]]
        $Function
    )

    $pool = Get-Variable -Name "ALCommonRunspacePool_$($ThrottleLimit)_$($ApartmentState)" -Scope Script -ErrorAction SilentlyContinue
    $InitialSessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()

    foreach ($func in $Function)
    {
        $ssFunc = [System.Management.Automation.Runspaces.SessionStateFunctionEntry]::new($func.Name, $func.ScriptBlock)
        $InitialSessionState.Commands.Add($ssFunc)
    }

    foreach ($var in $Variable)
    {
        $sessionVariable = [System.Management.Automation.Runspaces.SessionStateVariableEntry]::new($var.Name, $var.Value, $null)
        $InitialSessionState.Variables.Add($sessionVariable)
    }

    if (-not ($pool))
    {
        Write-Verbose -Message "Creating new runspace pool. Maximum Runspaces: $ThrottleLimit, ApartmentState: $ApartmentState, Variables: $($Variable.Count)"
        $pool = New-Variable -Name "ALCommonRunspacePool_$($ThrottleLimit)_$($ApartmentState)" -Scope Script -Value $([runspacefactory]::CreateRunspacePool($InitialSessionState)) -PassThru
        [void] $($pool.Value.SetMaxRunspaces($ThrottleLimit))

        if ($PSEdition -eq 'Desktop')
        {
            $pool.Value.ApartmentState = $ApartmentState
        }
    }
        
    $pool.Value
}
