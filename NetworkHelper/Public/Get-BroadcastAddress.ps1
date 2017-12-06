Function Get-BroadcastAddress
{
    <#
    .Synopsis
    Takes an IP address and subnet mask then calculates the broadcast address for the range.
    .Description
    Get-BroadcastAddress returns the broadcast address for a subnet by performing a bitwise AND 
    operation against the decimal forms of the IP address and inverted subnet mask. 
    Get-BroadcastAddress expects both the IP address and subnet mask in dotted decimal format.
    .Parameter IPAddress
    Any IP address within the network range.
    .Parameter SubnetMask
    The subnet mask for the network.
  #>
	
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
