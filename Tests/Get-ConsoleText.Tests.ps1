if (-not $ENV:BHModulePath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module $ENV:BHModulePath -Force

InModuleScope -ModuleName $ENV:BHProjectName {
    Describe "Get-ConsoleText" {

    }
}
