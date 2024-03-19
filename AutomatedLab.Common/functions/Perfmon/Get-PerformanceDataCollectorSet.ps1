function Get-PerformanceDataCollectorSet
{
    Param(
        [Parameter(Mandatory = $true)]
        [string]$CollectorSetName,

        [string]$ComputerName = 'localhost'
    )

    $collectorSet = New-Object -ComObject Pla.DataCollectorSet

    try
    {
        $collectorSet.Query($CollectorSetName, $ComputerName)
        return $collectorSet
    }
    catch
    {
        Write-Error -Message "Could not query data collector set. The error was: $($_.Exception.Message)" -Exception $_.Exception
    }
}
