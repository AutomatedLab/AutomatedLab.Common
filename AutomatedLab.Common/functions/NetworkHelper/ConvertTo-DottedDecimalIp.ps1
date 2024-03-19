function ConvertTo-DottedDecimalIP
{
    [CmdLetBinding()]
    [OutputType([String])]
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
            {$_ -as [Uint32]}
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
                throw 'Cannot convert this format'
            }
        }
    }
}
