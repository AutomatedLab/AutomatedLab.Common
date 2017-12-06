if (-not $ENV:BHProjectPath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Force

InModuleScope $ENV:BHProjectName {
    Describe "Add-StringIncrement" {
        Context "Add-StringIncrement" {
            $testData = @{
                'Test'                      = 'Test 0'
                'Test 665'                  = 'Test 666'
                "Test $([int64]::MaxValue)" = 'nA'
                'Test -10'                  = 'Test -10 0'
            }

            foreach ($testItem in $testData.GetEnumerator())
            {
                if ( $testItem.Value -ne 'nA')
                {
                    It "Should return $($testItem.Value)" {
                        Add-StringIncrement -String $testItem.Key | Should BeExactly $testItem.Value
                    }

                    It "Should not throw" {
                        {Add-StringIncrement -String $testItem.Key} | Should Not Throw
                    }
                }
                else
                {
                    It "Should throw" {
                        {Add-StringIncrement -String $testItem.Key} | Should Throw
                    }    
                }
            }
        }
    }
}