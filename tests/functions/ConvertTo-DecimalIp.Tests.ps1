
Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module (Join-Path -Path $env:BHBuildOutput -ChildPath AutomatedLab.Common\AutomatedLab.Common.psd1) -Force
    
BeforeDiscovery {
    $goodTests = @(
        @{ InputData = '2.1.32.23'; Result = '33628183' }
        @{ InputData = '192.168.2.1'; Result = '3232236033' }
    )
    $badTests = @(
        @{ InputData = "" }
        @{ InputData = '777.543.123.656' }
    )
}


Describe "ConvertTo-DecimalIp" {

    Context "Valid IP" {
            
        It "Should return a binary dotted IP" -TestCases $goodTests {
            ConvertTo-DecimalIP -IPAddress $InputData | Should -BeExactly $Result
        }

        It "Should not throw an error" -TestCases $goodTests {
            { ConvertTo-DecimalIP -IPAddress $InputData } | Should -Not -Throw
        }
    }

    Context "Invalid IP" {
        It "Should -Throw on bad IP" -TestCases $badTests {
            { ConvertTo-DecimalIP -IPAddress $InputData } | Should -Throw
        }

        It "Should -Throw on empty string" -TestCases $badTests {
            { ConvertTo-DecimalIP -IPAddress $InputData } | Should -Throw
        }
    }
}
