param (
    [string]
    $Repository = 'PSGallery'
)

$modules = @("Pester", "PSScriptAnalyzer", 'PlatyPS', 'PSFileTransfer', 'PSFramework')

# Automatically add missing dependencies
$data = Import-PowerShellDataFile -Path "$PSScriptRoot/../AutomatedLab.Common/AutomatedLab.Common.psd1"
foreach ($dependency in $data.RequiredModules) {
    if ($dependency -is [string]) {
        if ($modules -contains $dependency) { continue }
        $modules += $dependency
    }
    else {
        if ($modules -contains $dependency.ModuleName) { continue }
        $modules += $dependency.ModuleName
    }
}

foreach ($module in $modules) {
    Write-Host "Installing $module" -ForegroundColor Cyan
    Install-Module $module -Force -SkipPublisherCheck -Repository $Repository
    Import-Module $module -Force -PassThru
}