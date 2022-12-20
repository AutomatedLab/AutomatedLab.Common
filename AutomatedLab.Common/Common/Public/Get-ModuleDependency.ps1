function Get-ModuleDependency
{
	[CmdletBinding()]
	param
	(
        [Parameter(Mandatory = $true)]
		[System.Management.Automation.PSModuleInfo]
		$Module,

        [switch]
        $AsModuleInfo
	)

	if ($Module.RequiredModules)
	{
		Write-Verbose "$($Module.Name) has required modules"
		foreach ($moduleName in $Module.RequiredModules)
		{
			$moduleInfo = Get-Module -ListAvailable -Name $moduleName.Name
			if ($moduleName.Version) {$moduleInfo = $moduleInfo | Where-Object Version -eq $moduleName.Version}
			$moduleInfo = $moduleInfo | Sort-Object Version -Descending | Select-Object -First 1
			Write-Verbose "Detecting dependencies for $($moduleInfo.Name)"
			Get-ModuleDependency -Module $moduleInfo -AsModuleInfo:$AsModuleInfo.IsPresent
		}
	}
	
	if ($AsModuleInfo.IsPresent)
    {
        return $Module
    }
    
    $Module.ModuleBase
}
