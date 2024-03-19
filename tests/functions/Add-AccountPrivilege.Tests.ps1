
Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module (Join-Path -Path $env:BHBuildOutput -ChildPath AutomatedLab.Common\AutomatedLab.Common.psd1) -Force
    
BeforeDiscovery {
    $testCases = @(
        @{
            UserName  = @("Usera", "Userb")
            Privilege = @("SeUndockPrivilege", "SeShutdownPrivilege")
        }
    )
}

Describe Add-AccountPrivilege {
    Context 'User is administrator on system' {
        BeforeEach {
            Mock -ModuleName AutomatedLab.Common -CommandName New-Object -MockWith {
                return ("" | Add-Member -MemberType ScriptMethod -Name AddPrivileges -Value {} -PassThru)
            }
        }

        It 'Should -Not -Throw' -TestCases $testCases {
            { Add-AccountPrivilege -UserName $UserName -Privilege $Privilege } | Should -Not -Throw
            
            Should -Invoke -CommandName New-Object -ModuleName AutomatedLab.Common
        }
    }

    Context 'User is not administrator on system' {
        BeforeEach {
            Mock -ModuleName AutomatedLab.Common -CommandName New-Object -MockWith {
                return ("" | Add-Member -MemberType ScriptMethod -Name AddPrivileges -Value { throw 'An error' } -PassThru)
            }
        }

        It 'Should -Throw' -TestCases $testCases {
            { Add-AccountPrivilege -UserName $UserName -Privilege $Privilege } | Should -Throw
        }
    }
}