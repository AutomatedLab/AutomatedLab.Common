function Test-HashtableKeys
{
    [CmdletBinding()]
    [OutputType([bool])]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    param (
        [Parameter(Mandatory = $true)]
        [hashtable]$Hashtable,

        [string[]]$MandatoryKeys,

        [string[]]$ValidKeys,

        [switch]$Quiet
    )

    $result = $true

    if ($ValidKeys)
    {
        $compareResult = Compare-Object -ReferenceObject $ValidKeys -DifferenceObject ([array]$Hashtable.Keys) | Where-Object SideIndicator -eq '=>'
        if ($compareResult -and -not $Quiet)
        {
            Write-Error "The keys '$($compareResult.InputObject -join ', ')' are not valid"
        }

        $result = -not $compareResult
    }

    if ($MandatoryKeys)
    {
        $compareResult = Compare-Object -ReferenceObject $MandatoryKeys -DifferenceObject ([array]$Hashtable.Keys) | Where-Object SideIndicator -eq '<='
        if ($compareResult -and -not $Quiet)
        {
            Write-Error "The keys '$($compareResult.InputObject -join ', ')' are mandatory and not defined"
        }

        $result = -not $compareResult
    }

    $result
}
