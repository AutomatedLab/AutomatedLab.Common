﻿param (
	$TestGeneral = $true,
	
	$TestFunctions = $true,
	
	[ValidateSet('None', 'Normal', 'Detailed', 'Diagnostic')]
	[Alias('Show')]
	$Output = "None",
	
	$Include = "*",
	
	$Exclude = ""
)

Write-Host "Starting Tests"

Write-Host "Importing Module"

$global:testroot = $PSScriptRoot
$global:__pester_data = @{ }

Remove-Module AutomatedLab.Common -ErrorAction Ignore
Import-Module "$PSScriptRoot/../publish/AutomatedLab.Common/AutomatedLab.Common.psd1"
Import-Module "$PSScriptRoot/../publish/AutomatedLab.Common/AutomatedLab.Common.psm1" -Force

# Need to import explicitly so we can use the configuration class
Import-Module Pester

Write-Host  "Creating test result folder"
$null = New-Item -Path "$PSScriptRoot/.." -Name TestResults -ItemType Directory -Force

$totalFailed = 0
$totalRun = 0

$testresults = @()
$config = [PesterConfiguration]::Default
$config.TestResult.Enabled = $true

#region Run General Tests
if ($TestGeneral)
{
	Write-Host  "Modules imported, proceeding with general tests"
	foreach ($file in (Get-ChildItem "$PSScriptRoot/general" | Where-Object Name -like "*.Tests.ps1"))
	{
		if ($file.Name -notlike $Include) { continue }
		if ($file.Name -like $Exclude) { continue }

		Write-Host  "  Executing $($file.Name)"
		$config.TestResult.OutputPath = Join-Path "$PSScriptRoot/../TestResults" "TEST-$($file.BaseName).xml"
		$config.Run.Path = $file.FullName
		$config.Run.PassThru = $true
		$config.Output.Verbosity = $Output
    	$results = Invoke-Pester -Configuration $config
		foreach ($result in $results)
		{
			$totalRun += $result.TotalCount
			$totalFailed += $result.FailedCount
			$result.Tests | Where-Object Result -ne 'Passed' | ForEach-Object {
				$testresults += [pscustomobject]@{
					Block    = $_.Block
					Name	 = "It $($_.Name)"
					Result   = $_.Result
					Message  = $_.ErrorRecord.DisplayErrorMessage
				}
			}
		}
	}
}
#endregion Run General Tests

$global:__pester_data.ScriptAnalyzer | Out-Host

#region Test Commands
if ($TestFunctions)
{
	Write-Host "Proceeding with individual tests"
	foreach ($file in (Get-ChildItem "$PSScriptRoot/functions" -Recurse -File | Where-Object Name -like "*Tests.ps1"))
	{
		if ($file.Name -notlike $Include) { continue }
		if ($file.Name -like $Exclude) { continue }
		
		Write-Host "  Executing $($file.Name)"
		$config.TestResult.OutputPath = Join-Path "$PSScriptRoot/../TestResults" "TEST-$($file.BaseName).xml"
		$config.Run.Path = $file.FullName
		$config.Run.PassThru = $true
		$config.Output.Verbosity = $Output
    	$results = Invoke-Pester -Configuration $config
		foreach ($result in $results)
		{
			$totalRun += $result.TotalCount
			$totalFailed += $result.FailedCount
			$result.Tests | Where-Object Result -ne 'Passed' | ForEach-Object {
				$testresults += [pscustomobject]@{
					Block    = $_.Block
					Name	 = "It $($_.Name)"
					Result   = $_.Result
					Message  = $_.ErrorRecord.DisplayErrorMessage
				}
			}
		}
	}
}
#endregion Test Commands

$testresults | Sort-Object Describe, Context, Name, Result, Message | Format-List

if ($totalFailed -eq 0) { Write-Host  "All $totalRun tests executed without a single failure!" }
else { Write-Host "$totalFailed tests out of $totalRun tests failed!" }

if ($totalFailed -gt 0)
{
	throw "$totalFailed / $totalRun tests failed!"
}