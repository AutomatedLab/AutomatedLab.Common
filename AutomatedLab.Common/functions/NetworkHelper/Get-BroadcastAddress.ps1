Function Get-BroadcastAddress
{


    [CmdLetBinding()]
    Param (
        [Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True)]
        [Net.IPAddress]$IPAddress,

        [Parameter(Mandatory = $True, Position = 1)]
        [Alias('Mask')]
        [Net.IPAddress]$SubnetMask
    )

    process
    {
        return ConvertTo-DottedDecimalIP $((ConvertTo-DecimalIP $IPAddress) -BOr `
            ((-bnot (ConvertTo-DecimalIP $SubnetMask)) -band [UInt32]::MaxValue))
    }
}
