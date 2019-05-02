if (-not $ENV:BHModulePath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module $ENV:BHModulePath -Force -Verbose

InModuleScope -ModuleName $ENV:BHProjectName {
    Describe "Add-VariableToPSSession" {

    }
}
