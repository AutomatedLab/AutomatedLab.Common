function Get-StringSection
{
    [CmdletBinding()]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSReviewUnusedParameter", "")]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$String,

        [Parameter(Mandatory = $true)]
        [int]$SectionSize
    )

    process
    {
        0..($String.Length - 1) |
            Group-Object -Property { [System.Math]::Truncate($_ / $SectionSize) } |
            ForEach-Object { -join $String[$_.Group] }
    }
}
