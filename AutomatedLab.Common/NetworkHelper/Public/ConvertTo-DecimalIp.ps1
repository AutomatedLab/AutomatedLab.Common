Function ConvertTo-DecimalIP
{
    
	
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
