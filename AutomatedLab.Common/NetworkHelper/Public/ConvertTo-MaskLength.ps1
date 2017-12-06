Function ConvertTo-MaskLength
{
    <#
    .Synopsis
    Returns the length of a subnet mask.
    .Description
    ConvertTo-MaskLength accepts any IPv4 address as input, however the output value 
    only makes sense when using a subnet mask.
    .Parameter SubnetMask
    A subnet mask to convert into length
  #>
	
    [CmdLetBinding()]
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
