function Start-RunspaceJob
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [System.Management.Automation.ScriptBlock]
        $ScriptBlock,

        [Parameter(Mandatory)]
        [System.Management.Automation.Runspaces.RunspacePool]
        $RunspacePool,

        [Parameter()]
        [Object[]]
        $Argument
    )

    if ($RunspacePool.RunspacePoolStateInfo.State -eq 'Closed')
    {
        Write-Error -Message "Runspace pool $($RunspacePool.InstanceId) is already closed. Cannot queue job."
        return
    }

    if ($RunspacePool.RunspacePoolStateInfo.State -ne 'Opened')
    {
        $RunspacePool.Open()
    }

    $shell = [powershell]::Create()
    $shell.RunspacePool = $RunspacePool
    [void] $($shell.AddScript($ScriptBlock, $true))

    foreach ($arg in $Argument)
    {
        [void] $($shell.AddArgument($arg))
    }

    [PSCustomObject]@{
        Shell  = $shell
        Handle = $shell.BeginInvoke()
    }
}
