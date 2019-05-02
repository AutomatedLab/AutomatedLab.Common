if (-not $ENV:BHModulePath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module $ENV:BHModulePath -Force -Verbose

InModuleScope -ModuleName $ENV:BHProjectName {
    Describe "Get-FullMesh" {
        $testData = @('Entry1', 'Entry2', 'Entry3')
        $testDataSingle = 42
        $results = @('Entry1', 'Entry1', 'Entry2', 'Entry2', 'Entry3', 'Entry3')
        $resultsSourceOneway = @('Entry1', 'Entry1', 'Entry2')
        $resultsDestinationOneway = @('Entry2', 'Entry3', 'Entry3')
        
        Context 'Two-way' {
            It 'Should return a full mesh on arrays' {
                ((Get-FullMesh -List $testData).Source | Sort-Object) | Should Be $results
                ((Get-FullMesh -List $testData).Destination | Sort-Object) | Should Be $results
            }

            It 'Should return $null on single values' {
                Get-FullMesh -List $testDataSingle | Should Be $null
            }

            It 'Should not throw' {
                {Get-FullMesh -List $testData} | Should Not throw
            }
        }

        Context 'One-way' {
            It 'Should return a one-way mesh on arrays' {
                ((Get-FullMesh -List $testData -OneWay).Source | Sort-Object) | Should Be $resultsSourceOneway
                ((Get-FullMesh -List $testData -OneWay).Destination | Sort-Object) | Should Be $resultsDestinationOneway
            }

            It 'Should return $null on single values' {
                Get-FullMesh -List $testDataSingle -OneWay | Should Be $null
            }

            It 'Should not throw' {
                {Get-FullMesh -List $testData -OneWay} | Should Not throw
            }
        }
    }
}
