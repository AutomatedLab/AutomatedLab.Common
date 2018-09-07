function Get-RunspacePool
{
    [OutputType([System.Management.Automation.Runspaces.RunspacePool[]])]
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [int]
        $ThrottleLimit,

        [Parameter()]
        [System.Threading.ApartmentState]
        $ApartmentState
    )

    $pools = $(Get-Variable -Name ALCommonRunspacePool_* -ErrorAction SilentlyContinue).Value

    if ($ThrottleLimit)
    {
        $pools = $pools.Where({$_.GetMaxRunspaces() -eq $ThrottleLimit})
    }

    if ($ApartmentState)
    {
        $pools = $pools.Where({$_.ApartmentState -eq $ApartmentState})
    }

    $pools
}
