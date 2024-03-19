
Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module (Join-Path -Path $env:BHBuildOutput -ChildPath AutomatedLab.Common\AutomatedLab.Common.psd1) -Force
    
BeforeDiscovery {
    $goodTests = @(
        @{ InputData = '3232236033'; Result = '192.168.2.1' }
        @{ InputData = '11010010.10010110.10101010.01010101'; Result = '210.150.170.85' }
    )
    $badTests = @(
        @{ InputData = "" }
        @{ InputData = '-123123123' }
    )
}


    Describe "ConvertTo-DottedDecimalIp" {

        Context "Valid data" {
            It "Should convert <InputData>" -TestCases $goodTestst {
                ConvertTo-DottedDecimalIP -IPAddress $InputData | Should BeExactly $Result
            }
            It "Should -Not -Throw with <InputData>" -TestCases $goodTestst {
                {ConvertTo-DottedDecimalIP -IPAddress $InputData} | Should -Not -Throw
            }
        }

        Context "Invalid data" {
            It "Should throw an error" -TestCases $badTests {
                {ConvertTo-DottedDecimalIP -IPAddress $InputData} | Should -Throw
            }
        }
    }
