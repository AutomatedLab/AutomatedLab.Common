if (-not $ENV:BHModulePath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module $ENV:BHModulePath -Force -Verbose

InModuleScope -ModuleName $ENV:BHProjectName {
    Describe "ConvertTo-BinaryIp" {
        $goodIp = "192.168.2.1"
        $badIp = "555.123.123.123"
        $noIpAtAll = ""

        Context "Valid IP" {
            
            It "Should return a binary dotted IP" {
                ConvertTo-BinaryIP -IPAddress $goodIp | Should BeExactly "11000000.10101000.00000010.00000001"
            }

            It "Should not throw" {
                {ConvertTo-BinaryIP -IPAddress $goodIp} | Should Not Throw
            }
        }

        Context "Invalid IP" {
            It "Should throw on bad IP" {
                {ConvertTo-BinaryIP -IPAddress $badIp} | Should Throw
            }

            It "Should throw on empty string" {
                {ConvertTo-BinaryIP -IPAddress $noIpAtAll} | Should Throw
            }
        }
    }
}