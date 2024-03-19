Function Get-NetworkAddress
{


    [CmdLetBinding()]
    Param (
        [Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True)]
        [Net.IPAddress]$IPAddress,

        [Parameter(Mandatory = $True, Position = 1)]
        [Alias('Mask')]
        [Net.IPAddress]$SubnetMask
    )

    Process
    {
        Return ConvertTo-DottedDecimalIP ((ConvertTo-DecimalIP $IPAddress) -BAnd (ConvertTo-DecimalIP $SubnetMask))
    }
}
