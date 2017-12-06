function Get-NextOid
{
    param(
        [Parameter(Mandatory = $true)]
        [string]$Oid
    )
    
    $oidRange = $Oid.Substring(0, $Oid.LastIndexOf('.'))
    $lastNumber = $Oid.Substring($Oid.LastIndexOf('.') + 1)
    '{0}.{1}' -f $oidRange, ([int]$lastNumber + 1)
}
