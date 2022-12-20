#author Iain Brighton, from here: https://gist.github.com/iainbrighton/9d3dd03630225ee44126769c5d9c50a9
function Get-RequiredModulesFromMOF
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Path
    )
    process
    {

        $modules = @{ }
        $moduleName = $null
        $moduleVersion = $null

        Get-Content -Path $Path -Encoding Unicode | ForEach-Object {
    
            $line = $_;
            if ($line -match '^\s?Instance of')
            {
                ## We have a new instance so write the existing one
                if (($null -ne $moduleName) -and ($null -ne $moduleVersion))
                {
            
                    $modules[$moduleName] = $moduleVersion;
                    $moduleName = $null
                    $moduleVersion = $null
                    Write-Verbose "Module Instance found: $moduleName $moduleVersion"
                }
            }
            elseif ($line -match '(?<=^\s?ModuleName\s?=\s?")\S+(?=";)')
            {

                ## Ignore the default PSDesiredStateConfiguration module
                if ($Matches[0] -notmatch 'PSDesiredStateConfiguration')
                {
                    $moduleName = $Matches[0]
                    Write-Verbose "Found Module Name $modulename"
                }
                else
                {
                    Write-Verbose 'Excluding PSDesiredStateConfiguration module'
                }
            }
            elseif ($line -match '(?<=^\s?ModuleVersion\s?=\s?")\S+(?=";)')
            {
                $moduleVersion = $Matches[0] -as [System.Version]
                Write-Verbose "Module version = $moduleVersion"
            }
        }

        Write-Output -InputObject $modules
    } #end process
}
