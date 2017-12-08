if (-not $ENV:BHProjectPath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Force

InModuleScope -ModuleName $ENV:BHProjectName {
    Describe "ConvertTo-DecimalIp" {
        $goodIp = '192.168.2.1'
        $badIp = '555.123.123.123'
        $noIpAtAll = ""

        Context "Valid IP" {
            
            It "Should return a binary dotted IP" {
                ConvertTo-DecimalIP -IPAddress $goodIp | Should BeExactly 3232236033
            }

            It "Should not throw" {
                {ConvertTo-DecimalIP -IPAddress $goodIp} | Should Not Throw
            }
        }

        Context "Invalid IP" {
            It "Should throw on bad IP" {
                {ConvertTo-DecimalIP -IPAddress $badIp} | Should Throw
            }

            It "Should throw on empty string" {
                {ConvertTo-DecimalIP -IPAddress $noIpAtAll} | Should Throw
            }
        }
    }
}
