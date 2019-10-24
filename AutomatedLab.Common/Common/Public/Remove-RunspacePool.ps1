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
                $state = if ($null -ne $pool.ApartmentState) { $pool.ApartmentState } else {'Unknown'}

                $pool.Close()
                $pool.Dispose()

                Write-Verbose -Message "Attempting to remove ALCommonRunspacePool_$($max)_$($state)"
                Remove-Variable -Name "ALCommonRunspacePool_$($max)_$($state)" -Scope Script -ErrorAction SilentlyContinue
            }
        }
    }
}
