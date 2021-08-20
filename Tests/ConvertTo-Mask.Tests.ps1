
if (-not $ENV:BHModulePath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module $ENV:BHModulePath -Force
    
BeforeDiscovery {
    
    $testValid = @(
        @{ Mask = '255.255.252.0'; Length = 22 }        
        @{ Mask = '255.0.0.0'; Length = 8 }        
        @{ Mask = '255.255.0.0'; Length = 16 }
        @{ Mask = '255.255.255.254'; Length = 31 }
    )
    $testInvalid = @(
        @{ Length = -1 }
        @{ Length = 42 }
    )
}

Describe "ConvertTo-Mask" {
        
    Context "Valid data" {
        It "Should work" -TestCases $testValid {
            ConvertTo-Mask -MaskLength $Length | Should -BeExactly $Mask
        }

        It "Should not throw an error" -TestCases $testValid {
            { ConvertTo-Mask -MaskLength $Length } | Should -Not -Throw
        }
    }
    Context "Invalid data" {
        It "Should -Throw with CIDR <Length>" -TestCases $testInvalid {
            { ConvertTo-Mask -MaskLength $Length } | Should -Throw
        }
    }
    
}