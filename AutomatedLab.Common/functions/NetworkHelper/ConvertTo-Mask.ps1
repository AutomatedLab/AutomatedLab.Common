Function ConvertTo-Mask
{
    [CmdLetBinding()]
    [OutputType([String])]
    Param (
        [Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True)]
        [Alias('Length')]
        [ValidateRange(0, 32)]
        $MaskLength
    )

    Process
    {
        Return ConvertTo-DottedDecimalIP ([Convert]::ToUInt32($(('1' * $MaskLength).PadRight(32, '0')), 2))
    }
}
