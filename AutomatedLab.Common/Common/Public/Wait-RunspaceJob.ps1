function Wait-RunspaceJob
{
    [CmdletBinding()]
    param
    (
        [Parameter(ValueFromPipeline)]
        [object[]]
        $RunspaceJob,

        [Parameter()]
        [switch]
        $PassThru
    )

    process
    {
        while ($RunspaceJob.Handle.IsCompleted -contains $false)
        {
            Start-Sleep -Milliseconds 100
        }
    }

    end
    {
        if ($PassThru) { $RunspaceJob }
    }
}
