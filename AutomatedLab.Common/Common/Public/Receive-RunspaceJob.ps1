function Receive-RunspaceJob
{
    [CmdletBinding()]
    param
    (
        [Parameter(ValueFromPipeline = $true)]
        [object[]]
        $RunspaceJob
    )

    process
    {
        while ($RunspaceJob.Handle.IsCompleted -contains $false)
        {
            Start-Sleep -Milliseconds 100
        }

        foreach ($job in $RunspaceJob)
        {
            $job.Shell.EndInvoke($job.handle)    
            $job.Shell.Dispose()    
        }
    }
}
