
if (-not $ENV:BHModulePath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module $ENV:BHModulePath -Force
    
BeforeDiscovery {
    $testDataGood = @(
        @{Value = 'Test'; Result = 'Test 0' }
        @{Value = 'Test 665' ; Result = 'Test 666' }
        @{Value = 'Test -10' ; Result = 'Test -10 0' }
    )
    $testDataBad = @(    
        @{Value = "Test $([int64]::MaxValue)" ; Result = 'nA' }
    )
}

    Describe "Add-StringIncrement" {
        Context "Add-StringIncrement" {
            It "Should return <Result>" -TestCases $testDataGood {
                Add-StringIncrement -String $Value | Should -BeExactly $Result
            }

            It "Should not throw an error" -TestCases $testDataGood {
                { Add-StringIncrement -String $Value } | Should -Not -Throw
            }
            It "Should throw an error"  -TestCases $testDataBad {
                { Add-StringIncrement -String $Value } | Should -Throw
            }
        }
    }