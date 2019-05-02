if (-not $ENV:BHModulePath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module $ENV:BHModulePath -Force -Verbose

InModuleScope -ModuleName $ENV:BHProjectName {
    Describe "ConvertTo-MaskLength" {
        $validMask = "255.255.252.0"
        $invalidMask = "-1.3.4.5"

        Context "valid data" {
            It "Should work" {
                ConvertTo-MaskLength -SubnetMask $validMask | Should BeExactly 22
            }

            It "SHould not throw" {
                {ConvertTo-MaskLength -SubnetMask $validMask} | Should Not Throw
            }
        }

        Context "Invalid data" {
            It "Should throw" {
                {ConvertTo-MaskLength -SubnetMask $invalidMask} | Should Throw
            }
        }
    }
}
