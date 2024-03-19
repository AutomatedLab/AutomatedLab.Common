
Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module (Join-Path -Path $env:BHBuildOutput -ChildPath AutomatedLab.Common\AutomatedLab.Common.psd1) -Force
    
BeforeDiscovery {
    $testDataArrays = @(
        @{
            InputData               = @('Entry1', 'Entry2', 'Entry3')
            ResultTwoWay            = @('Entry1', 'Entry1', 'Entry2', 'Entry2', 'Entry3', 'Entry3')
            ResultOneWaySource      = @('Entry1', 'Entry1', 'Entry2')
            ResultOneWayDestination = @('Entry2', 'Entry3', 'Entry3')
        }
        @{InputData = 'A string' }
    )
    $testDataSingles = @(
        @{InputData = 42 }
        @{InputData = 'A string' }
    )
}


    Describe "Get-FullMesh" {
        
        Context 'Two-way' {
            It 'Should return a full mesh on arrays' -TestCases $testDataArrays {
                ((Get-FullMesh -List $InputData).Source | Sort-Object) | Should -Be $ResultTwoWay
                ((Get-FullMesh -List $InputData).Destination | Sort-Object) | Should -Be $ResultTwoWay
            }

            It 'Should return $null on single value <InputData>' -TestCases $testDataSingles {
                Get-FullMesh -List $InputData | Should -BeNullOrEmpty
            }

            It 'Should -Not -Throw'  -TestCases $testDataArrays {
                { Get-FullMesh -List $InputData } | Should -Not -Throw
            }
        }

        Context 'One-way' {
            It 'Should return a one-way mesh on arrays' -TestCases $testDataArrays {
                ((Get-FullMesh -List $InputData -OneWay).Source | Sort-Object) | Should -Be $ResultOneWaySource
                ((Get-FullMesh -List $InputData -OneWay).Destination | Sort-Object) | Should -Be $ResultOneWayDestination
            }

            It 'Should return $null on single value <InputData>' -TestCases $testDataSingles {
                Get-FullMesh -List $InputData -OneWay | Should -BeNullOrEmpty
            }

            It 'Should -Not -Throw' -TestCases $testDataArrays {
                { Get-FullMesh -List $InputData -OneWay } | Should -Not -Throw
            }
        }
    }
