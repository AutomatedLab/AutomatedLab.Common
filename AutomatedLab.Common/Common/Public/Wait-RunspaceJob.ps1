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

    begin
    {
        $jobs = @()
    }

    process
    {
        $jobs += $RunspaceJob
    }

    end
    {
        while ($jobs.Handle.IsCompleted -contains $false)
        {
            Start-Sleep -Milliseconds 100
        }

        if ($PassThru) { $jobs }
    }
}
