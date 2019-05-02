if (-not $ENV:BHModulePath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\..
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Force
Import-Module $ENV:BHModulePath -Force -Verbose

InModuleScope -ModuleName $ENV:BHProjectName {
    Describe "ConvertTo-Mask" {
        $validMask = 22
        $invalidMasks = @(-1, 33)
        Context "Valid data" {
            It "Should work" {
                ConvertTo-Mask -MaskLength $validMask | Should BeExactly "255.255.252.0"
            }

            It "Should not throw" {
                {ConvertTo-Mask -MaskLength $validMask} | Should Not Throw
            }
        }
        Context "Invalid data" {
            foreach ($mask in $invalidMasks)
            {
                It "Should Throw with mask $mask" {
                    {ConvertTo-Mask -MaskLength $mask} | Should Throw
                }
            }
        }
    }
}
