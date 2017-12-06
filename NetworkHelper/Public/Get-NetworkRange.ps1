function Get-NetworkRange
{
	param (
		[string]$IPAddress,
		[string]$SubnetMask
	)
	
	if ($IPAddress.Contains('/'))
	{
		$temp = $IPAddress.Split('/')
		$IPAddress = $temp[0]
		$SubnetMask = $temp[1]
	}
	
	If (-not $SubnetMask.Contains('.'))
	{
		$SubnetMask = ConvertTo-Mask -MaskLength $SubnetMask
	}
	
	$decimalIP = ConvertTo-DecimalIP -IPAddress $IPAddress
	$decimalMask = ConvertTo-DecimalIP -IPAddress $SubnetMask
	
	$network = $decimalIP -band $decimalMask
	$broadcast = $decimalIP -bor ((-bnot $decimalMask) -band [UInt32]::MaxValue)
	
	for ($i = $($network + 1); $i -lt $broadcast; $i++)
	{
		ConvertTo-DottedDecimalIP -IPAddress $i
	}
}
