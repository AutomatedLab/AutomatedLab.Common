function Remove-RunspacePool
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param
    (
        [Parameter(ValueFromPipeline)]
        [System.Management.Automation.Runspaces.RunspacePool[]]
        $RunspacePool
    )

    process
    {
        foreach ($pool in $RunspacePool)
        {
            if ($PSCmdlet.ShouldProcess($pool.InstanceId, 'Closing runspace pool'))
            {
                $max = $pool.GetMaxRunspaces()
                $state = $pool.ApartmentState

                $pool.Close()
                $pool.Dispose()

                Remove-Variable -Name "ALCommonRunspacePool_$($max)_$($state)" -Scope Global -ErrorAction SilentlyContinue
            }
        }
    }
}
