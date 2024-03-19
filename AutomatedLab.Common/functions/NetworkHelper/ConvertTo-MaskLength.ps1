Function ConvertTo-MaskLength
{
    [CmdLetBinding()]
    [OutputType([uint32])]
    Param (
        [Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True)]
        [Alias('Mask')]
        [Net.IPAddress]$SubnetMask
    )

    Process
    {
        $Bits = "$( $SubnetMask.GetAddressBytes() | ForEach-Object  -Process { [Convert]::ToString($_, 2)
    } )"
        $Bitsx = $Bits -Replace '[\s0]'

        Return $Bitsx.Length
    }
}
