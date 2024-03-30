<#
This script publishes the module to the gallery.
It expects as input an ApiKey authorized to publish the module.

Insert any build steps you may need to take before publishing it here.
#>
param (
	$ApiKey,
	
	$WorkingDirectory,
	
	$Repository = 'PSGallery',
	
	[switch]
	$LocalRepo,
	
	[switch]
	$SkipPublish,
	
	[switch]
	$AutoVersion,

    [switch]
    $Preview
)

#region Handle Working Directory Defaults
if (-not $WorkingDirectory)
{
	if ($env:RELEASE_PRIMARYARTIFACTSOURCEALIAS)
	{
		$WorkingDirectory = Join-Path -Path $env:SYSTEM_DEFAULTWORKINGDIRECTORY -ChildPath $env:RELEASE_PRIMARYARTIFACTSOURCEALIAS
	}
	else { $WorkingDirectory = $env:SYSTEM_DEFAULTWORKINGDIRECTORY }
}
if (-not $WorkingDirectory) { $WorkingDirectory = Split-Path $PSScriptRoot }
#endregion Handle Working Directory Defaults

# Prepare publish folder
Write-Host "Creating and populating publishing directory"
$publishDir = New-Item -Path $WorkingDirectory -Name publish -ItemType Directory -Force
Copy-Item -Path "$($WorkingDirectory)/AutomatedLab.Common" -Destination $publishDir.FullName -Recurse -Force
Copy-Item -Path "$($WorkingDirectory)/LICENSE" -Destination (Join-Path $publishDir -ChildPath "AutomatedLab.Common") -Force

# Build library
$projPath = Join-Path $WorkingDirectory -ChildPath 'Library/Library.csproj' -Resolve -ErrorAction Stop
dotnet publish $projPath -f net6.0 -o (Join-Path -Path $publishDir 'AutomatedLab.Common/lib/core')
dotnet publish $projPath -f net462 -o (Join-Path -Path $publishDir 'AutomatedLab.Common/lib/full')

# Get Help
foreach ($language in (Get-ChildItem -Path (Join-Path $WorkingDirectory -ChildPath Help) -Directory))
{
    $ci = try { [cultureinfo]$language.BaseName} catch { }
    if (-not $ci) {continue}
    New-ExternalHelp -Path $language.FullName -OutputPath (Join-Path $publishDir -ChildPath "AutomatedLab.Common/$($language.BaseName)") -Force
}

#region Gather text data to compile
$text = @()

# Gather commands
Get-ChildItem -Path "$($publishDir.FullName)/AutomatedLab.Common/internal/functions/" -Recurse -File -Filter "*.ps1" | ForEach-Object {
	$text += [System.IO.File]::ReadAllText($_.FullName)
}
Get-ChildItem -Path "$($publishDir.FullName)/AutomatedLab.Common/functions/" -Recurse -File -Filter "*.ps1" | ForEach-Object {
	$text += [System.IO.File]::ReadAllText($_.FullName)
}

# Gather scripts
Get-ChildItem -Path "$($publishDir.FullName)/AutomatedLab.Common/internal/scripts/" -Recurse -File -Filter "*.ps1" | ForEach-Object {
	$text += [System.IO.File]::ReadAllText($_.FullName)
}

#region Update the psm1 file & Cleanup
[System.IO.File]::WriteAllText("$($publishDir.FullName)/AutomatedLab.Common/AutomatedLab.Common.psm1", ($text -join "`n`n"), [System.Text.Encoding]::UTF8)
Remove-Item -Path "$($publishDir.FullName)/AutomatedLab.Common/internal" -Recurse -Force
Remove-Item -Path "$($publishDir.FullName)/AutomatedLab.Common/functions" -Recurse -Force
#endregion Update the psm1 file & Cleanup

#region Updating the Module Version
if ($AutoVersion)
{
	Write-Host  "Updating module version numbers."
	try { [version]$remoteVersion = (Find-Module 'AutomatedLab.Common' -Repository $Repository -ErrorAction Stop).Version }
	catch
	{
		throw "Failed to access $($Repository) : $_"
	}
	if (-not $remoteVersion)
	{
		throw "Couldn't find AutomatedLab.Common on repository $($Repository) : $_"
	}
	$newBuildNumber = $remoteVersion.Build + 1
	[version]$localVersion = (Import-PowerShellDataFile -Path "$($publishDir.FullName)/AutomatedLab.Common/AutomatedLab.Common.psd1").ModuleVersion
	Update-ModuleManifest -Path "$($publishDir.FullName)/AutomatedLab.Common/AutomatedLab.Common.psd1" -ModuleVersion "$($localVersion.Major).$($localVersion.Minor).$($newBuildNumber)"
}
#endregion Updating the Module Version

#region Setting preview info
if ($Preview.IsPresent)
{
	Write-Host  "Updating module version numbers."
	try { [version]$version, [string]$preRelease = (Find-Module 'AutomatedLab.Common' -Repository $Repository -ErrorAction Stop -AllowPrerelease).Version -split '-' }
	catch
	{
		throw "Failed to access $($Repository) : $_"
	}

	if (-not $version)
	{
		throw "Couldn't find AutomatedLab.Common on repository $($Repository) : $_"
	}

    [version]$localVersion = (Import-PowerShellDataFile -Path "$($publishDir.FullName)/AutomatedLab.Common/AutomatedLab.Common.psd1").ModuleVersion
    if ($localVersion -lt $version -or ($localVersion -eq $version -and -not $preRelease)) { throw "Local version is lower than the one on the repository. Cannot publish pre-release version."}
    if (-not $prerelease) { $prerelease = '{0:d6}' -f 1 } else { $prerelease = '{0:d6}' -f ($prerelease + 1) }

    Update-ModuleManifest -Path "$($publishDir.FullName)/AutomatedLab.Common/AutomatedLab.Common.psd1" -Prerelease $prerelease
}
#endregion

#region Publish
if ($SkipPublish) { return }
if ($LocalRepo)
{
	# Dependencies must go first
	Write-Host  "Creating Nuget Package for module: PSFramework"
	New-PSMDModuleNugetPackage -ModulePath (Get-Module -Name PSFramework).ModuleBase -PackagePath .
	Write-Host  "Creating Nuget Package for module: AutomatedLab.Common"
	New-PSMDModuleNugetPackage -ModulePath "$($publishDir.FullName)/AutomatedLab.Common" -PackagePath .
}
else
{
	# Publish to Gallery
	Write-Host  "Publishing the AutomatedLab.Common module to $($Repository)"
	Publish-Module -Path "$($publishDir.FullName)/AutomatedLab.Common" -NuGetApiKey $ApiKey -Force -Repository $Repository
}
#endregion Publish