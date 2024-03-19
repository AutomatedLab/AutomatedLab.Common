function Get-PerformanceCounterID
{
    [CmdletBinding()]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidInvokingEmptyMembers", "")]
    param
    (
        [Parameter(Mandatory = $true)]
        $Name
    )

    if ($null -eq $script:perfHash)
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
