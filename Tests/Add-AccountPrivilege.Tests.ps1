if (-not $ENV:BHProjectPath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue
Import-Module $ENV:BHProjectPath -Force


InModuleScope 'AutomatedLab.Common' {
    Describe Add-AccountPrivilege {
        $badLsa = New-Object psobject | Add-Member -MemberType ScriptMethod -Name AddPrivileges -Value {throw 'An error'} -PassThru
        $goodLsa = New-Object psobject | Add-Member -MemberType ScriptMethod -Name AddPrivileges -Value {} -PassThru
        $parameters = @{
            UserName  = @("Usera", "Userb")
            Privilege = @("SeUndockPrivilege", "SeShutdownPrivilege")
        }

        Context 'User is administrator on system' {
            Mock -CommandName New-Object -MockWith {
                return $goodLsa
            }

            It 'Should not throw' {
                {Add-AccountPrivilege @parameters} | Should Not Throw
            }

            It 'Should return $null' {
                (Add-AccountPrivilege @parameters)
            }

            Assert-MockCalled -CommandName New-Object
        }

        Context 'User is not administrator on system' {
            Mock -CommandName New-Object -MockWith {
                return $badLsa
            }

            It 'Should throw' {
                {Add-AccountPrivilege @parameters} | Should Throw
            }

            Assert-MockCalled -CommandName New-Object
        }
    }
}
