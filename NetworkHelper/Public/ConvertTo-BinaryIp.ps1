Function ConvertTo-BinaryIP
{
    <#
    .Synopsis
    Converts a Decimal IP address into a binary format.
    .Description
    ConvertTo-BinaryIP uses System.Convert to switch between decimal and binary format. The output from this function is dotted binary.
    .Parameter IPAddress
    An IP Address to convert.
  #>
	
    [CmdLetBinding()]
    Param (
        [Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True)]
        [Net.IPAddress]$IPAddress
    )
	
    Process
    {
        Return [String]::Join('.', $($IPAddress.GetAddressBytes() |
                    ForEach-Object -Process {
                    [Convert]::ToString($_, 2).PadLeft(8, '0')
                }
            ))
    }
}
