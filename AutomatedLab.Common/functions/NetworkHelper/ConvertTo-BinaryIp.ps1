Function ConvertTo-BinaryIP
{
    [CmdLetBinding()]
    [OutputType([String])]
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
