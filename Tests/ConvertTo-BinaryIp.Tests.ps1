if (-not $ENV:BHProjectPath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Force

InModuleScope -ModuleName $ENV:BHProjectName {
    Describe "ConvertTo-BinaryIp" {
        $goodIp = "192.168.2.1"
        $badIp = "555.123.123.123"

        Context "Valid IP" {
            
            It "Should return a binary dotted IP" {
                ConvertTo-BinaryIP -IPAddress $goodIp | Should BeExactly "11000000.10101000.00000010.00000001"
            }

            It "Should not throw" {
                {ConvertTo-BinaryIP -IPAddress $goodIp} | Should Not Throw
            }
        }

        Context "Invalid IP" {
            It "Should throw" {
                {ConvertTo-BinaryIP -IPAddress $badIp} | Should Throw
            }
        }
    }
}