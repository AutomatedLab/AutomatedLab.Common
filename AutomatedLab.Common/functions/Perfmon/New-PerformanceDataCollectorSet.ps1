function New-PerformanceDataCollectorSet
{
    [CmdletBinding(DefaultParameterSetName = 'Counter', SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    Param(
        [Parameter(Mandatory = $true)]
        [string]$CollectorSetName,

        [datetime]$StartDate,

        [Parameter(ParameterSetName = 'Counters')]
        [string[]]$Counters,

        [Parameter(ParameterSetName = 'Xml')]
        [string[]]$XmlTemplatePath,

        [string]$ComputerName = 'localhost'
    )

    if (-not $PSCmdlet.ShouldProcess($CollectorSetName, 'Create a new performance data collector set')) { return }

    if ((Get-PerformanceDataCollectorSet -CollectorSetName $CollectorSetName -ComputerName $ComputerName -ErrorAction SilentlyContinue))
    {
        Write-Error "There is already a data collector set named '$CollectorSetName' on machine '$ComputerName'"
        return
    }

    $collectorSet = New-Object -COM Pla.DataCollectorSet
    if ($XmlTemplatePath)
    {
        if (-not (Test-Path -Path $XmlTemplatePath -PathType Leaf))
        {
            Write-Error "The file '$XmlTemplatePath' could not be found."
            return
        }
        $xml = Get-Content -Path $XmlTemplatePath
        $collectorSet.SetXml($xml)
    }
    else
    {
        $collectorSet.DisplayName = $CollectorSetName
        $collectorSet.Duration = 50400
        $collectorSet.SubdirectoryFormat = 1
        $collectorSet.SubdirectoryFormatPattern = 'yyyy\-MM'
        $collectorSet.RootPath = "%systemdrive%\PerfLogs\Admin\$CollectorSetName"

        $collector = $collectorSet.DataCollectors.CreateDataCollector(0)
        $collector.FileName = $CollectorSetName + '_'
        $collector.FileNameFormat = 0x1
        $collector.FileNameFormatPattern = 'yyyy\-MM\-dd'
        $collector.SampleInterval = 15
        $collector.LogAppend = $true

        if (-not $Counters)
        {
            $Counters = @(
                '\PhysicalDisk\Avg. Disk Sec/Read',
                '\PhysicalDisk\Avg. Disk Sec/Write',
                '\PhysicalDisk\Avg. Disk Queue Length',
                '\Memory\Available MBytes',
                '\Processor(_Total)\% Processor Time',
                '\System\Processor Queue Length'
            )
        }

        $collector.PerformanceCounters = $Counters
        $collectorSet.DataCollectors.Add($collector)

        if ($StartDate)
        {
            $newSchedule = $collectorSet.Schedules.CreateSchedule()
            $newSchedule.Days = 127
            $newSchedule.StartDate = $StartDate
            $newSchedule.StartTime = $StartDate

            $collectorSet.Schedules.Add($newSchedule)
        }
    }

    try
    {
        $collectorSet.Commit($CollectorSetName, $ComputerName, 3) | Out-Null #3 = CreateOrModify
    }
    catch
    {
        Write-Error 'Exception Caught: ' $_.Exception -ForegroundColor Red
        return
    }
}
