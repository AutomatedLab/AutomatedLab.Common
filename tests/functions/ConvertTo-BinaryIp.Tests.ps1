Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module (Join-Path -Path $env:BHBuildOutput -ChildPath AutomatedLab.Common\AutomatedLab.Common.psd1) -Force
    
BeforeDiscovery {
    $goodTests = @(
        @{ InputData = '2.1.32.23'; Result = '00000010.00000001.00100000.00010111' }
        @{ InputData = '192.168.2.1'; Result = '11000000.10101000.00000010.00000001' }
    )
    $badTests = @(
        @{ InputData = "" }
        @{ InputData = '777.543.123.656' }
    )
}

    Describe "ConvertTo-BinaryIp" {

        Context "Valid IP" {
            
            It "Should return a binary dotted IP" -TestCases $goodTests {
                ConvertTo-BinaryIP -IPAddress $InputData | Should -BeExactly $Result
            }

            It "Should not throw an error" -TestCases $goodTests {
                { ConvertTo-BinaryIP -IPAddress $InputData } | Should -Not -Throw
            }
        }

        Context "Invalid IP" {
            It "Should -Throw on bad IP" -TestCases $badTests {
                { ConvertTo-BinaryIP -IPAddress $InputData } | Should -Throw
            }

            It "Should -Throw on empty string" -TestCases $badTests {
                { ConvertTo-BinaryIP -IPAddress $InputData } | Should -Throw
            }
        }
    }
