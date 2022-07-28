function Stop-PerformanceDataCollectorSet
{
    Param(
        [Parameter(Mandatory = $true)]
        [string]$CollectorSetName,
        
        [string]$ComputerName = 'localhost'
    )
    
    $collectorSet = Get-PerformanceDataCollectorSet -CollectorSetName $CollectorSetName -ComputerName $ComputerName -ErrorAction SilentlyContinue
    if (-not $collectorSet)
    {
        Write-Error "The data collector set '$CollectorSetName' could not be found on '$ComputerName'"
        return
    }
    
    try
    {
        $collectorSet.Stop($false)
    }
    catch
    {
        Write-Error -Message "Could not start data collector set. The error was: $($_.Exception.Message)" -Exception $_.Exception
    }
}