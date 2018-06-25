function Get-PerformanceCounterID
{
    param
    (
        [Parameter(Mandatory)]
        $Name
    )
 
    if ($script:perfHash -eq $null)
    {
        Write-Progress -Activity 'Retrieving PerfIDs' -Status 'Working'
 
        $key = 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\CurrentLanguage'
        $counters = (Get-ItemProperty -Path $key -Name Counter).Counter
        $script:perfHash = @{}
        $all = $counters.Count
 
        for($i = 0; $i -lt $all; $i += 2)
        {
            Write-Progress -Activity 'Retrieving PerfIDs' -Status 'Working' -PercentComplete ($i * 100 / $all)
            $script:perfHash.$($counters[$i + 1]) = $counters[$i]
        }
    }
 
    $script:perfHash.$Name
}