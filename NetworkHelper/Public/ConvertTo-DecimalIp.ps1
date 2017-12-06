Function ConvertTo-DecimalIP
{
  <#
    .Synopsis
    Converts a Decimal IP address into a 32-bit unsigned integer.
    .Description
    ConvertTo-DecimalIP takes a decimal IP, uses a shift-like operation on each octet and returns a single UInt32 value.
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
		$i = 3
		$decimalIP = 0
		$IPAddress.GetAddressBytes() | ForEach-Object -Process {
			$decimalIP += $_ * [Math]::Pow(256, $i)
			$i--
		}
		
		Return [UInt32]$decimalIP
	}
}
