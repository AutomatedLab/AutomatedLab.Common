
Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module (Join-Path -Path $env:BHBuildOutput -ChildPath AutomatedLab.Common\AutomatedLab.Common.psd1) -Force
    
BeforeDiscovery {
}


    Describe "Sync-Parameter" {

        It "does not throw when the command has no parameters" {
            function Test-NoParams1 { }

            { Sync-Parameter -Command (Get-Command -Name Test-NoParams1) -Parameters @{} } | Should -Not -Throw
        }

        It "does not throw when the parameter hashtable is empty" {
            { Sync-Parameter -Command (Get-Command -Name Get-Date) -Parameters @{} } | Should -Not -Throw
        }
    }
