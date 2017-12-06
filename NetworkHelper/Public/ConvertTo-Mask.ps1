Function ConvertTo-Mask
{
    <#
    .Synopsis
    Returns a dotted decimal subnet mask from a mask length.
    .Description
    ConvertTo-Mask returns a subnet mask in dotted decimal format from an integer value ranging 
    between 0 and 32. ConvertTo-Mask first creates a binary string from the length, converts 
    that to an unsigned 32-bit integer then calls ConvertTo-DottedDecimalIP to complete the operation.
    .Parameter MaskLength
    The number of bits which must be masked.
  #>
	
    [CmdLetBinding()]
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
