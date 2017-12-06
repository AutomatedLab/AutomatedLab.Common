Function ConvertTo-DottedDecimalIP
{
  <#
    .Synopsis
    Returns a dotted decimal IP address from either an unsigned 32-bit integer or a dotted binary string.
    .Description
    ConvertTo-DottedDecimalIP uses a regular expression match on the input string to convert to an IP address.
    .Parameter IPAddress
    A string representation of an IP address from either UInt32 or dotted binary.
  #>
	
	[CmdLetBinding()]
	Param (
		[Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True)]
		[String]$IPAddress
	)
	
	process
	{
		switch -RegEx ($IPAddress)
		{
			'([01]{8}\.){3}[01]{8}'
			{
				return [String]::Join('.', $($IPAddress.Split('.') | ForEach-Object -Process {
					[Convert]::ToUInt32($_, 2)
				}
				))
			}
			'\d'
			{
				$IPAddress = [UInt32]$IPAddress
				$dottedIP = $(For ($i = 3; $i -gt -1; $i--)
				{
					$remainder = $IPAddress % [Math]::Pow(256, $i)
					($IPAddress - $remainder) / [Math]::Pow(256, $i)
					$IPAddress = $remainder
				}
				)
				
				return [String]::Join('.', $dottedIP)
			}
			default
			{
				Write-Error 'Cannot convert this format'
			}
		}
	}
}
