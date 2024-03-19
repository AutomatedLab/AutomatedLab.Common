
Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module (Join-Path -Path $env:BHBuildOutput -ChildPath AutomatedLab.Common\AutomatedLab.Common.psd1) -Force
    
BeforeDiscovery {
    $testValid = @(
        @{ Mask = '255.255.252.0'; Length = 22 }        
        @{ Mask = '255.0.0.0'; Length = 8 }        
        @{ Mask = '255.255.0.0'; Length = 16 }
        @{ Mask = '255.255.255.254'; Length = 31 }
    )
    $testInvalid = @(
        @{ Mask = '-1.3.4.5'}
    )
}

    Describe "ConvertTo-MaskLength" {

        Context "valid data" {
            It "Should work" -TestCases $testValid {
                ConvertTo-MaskLength -SubnetMask $Mask | Should -BeExactly $Length
            }

            It "Should not throw an error" -TestCases $testValid {
                {ConvertTo-MaskLength -SubnetMask $Mask} | Should -Not -Throw
            }
        }

        Context "Invalid data" {
            It "Should throw an error" -TestCases $testInvalid {
                {ConvertTo-MaskLength -SubnetMask $Mask} | Should -Throw
            }
        }
    }
