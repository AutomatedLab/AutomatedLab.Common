if (-not $ENV:BHModulePath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module $ENV:BHModulePath -Force -Verbose

InModuleScope -ModuleName $ENV:BHProjectName {
    Describe "ConvertTo-DottedDecimalIp" {
        $goodDecimal = '3232236033' # 192.168.2.1
        $goodBinary = "11010010.10010110.10101010.01010101" # 210.150.170.85
        $badDecimal = -123123123

        Context "Valid data" {
            It "Should convert decimal addresses" {
                ConvertTo-DottedDecimalIP -IPAddress $goodDecimal | Should BeExactly "192.168.2.1"
            }
            It "Should not throw with a decimal address" {
                {ConvertTo-DottedDecimalIP -IPAddress $goodDecimal} | Should Not Throw
            }
            It "Should convert binary addresses" {
                ConvertTo-DottedDecimalIP -IPAddress $goodBinary | Should BeExactly "210.150.170.85"
            }
            It "Should not throw with a binary address" {
                {ConvertTo-DottedDecimalIP -IPAddress $goodBinary} | Should Not Throw
            }
        }

        Context "Invalid data" {
            It "Should throw" {
                {ConvertTo-DottedDecimalIP -IPAddress $badDecimal} | Should Throw
            }
        }
    }
}
