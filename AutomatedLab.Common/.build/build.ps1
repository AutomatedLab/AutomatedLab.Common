# Prepare and write new content to module instead of dot-sourcing
# Get public and private function definition files.
$importFolders = Get-ChildItem $env:BHPSModulePath -Exclude (Split-Path -Path $env:BHBuildOutput -Leaf) -Include Types, Public, Private -Recurse -Directory -ErrorAction SilentlyContinue

$sb = [System.Text.StringBuilder]::new()
$publicList = [System.Collections.ArrayList]::new()
foreach ($line in (Get-Content (Join-Path $env:BHPSModulePath AutomatedLab.Common.psm1)))
{
    if ($line -match '^\$importFolders') { break }

    $null = $sb.AppendLine()
    $null = $sb.Append($line)
}

foreach ($file in (Get-ChildItem -Recurse -Path $importFolders -Filter *.ps1))
{
    if ($file.Directory.Name -eq 'Public')
    {
        $null = $publicList.Add($file.Basename)
    }

    $null = $sb.AppendLine()
    $null = $sb.Append((Get-Content -Raw -Path $file.FullName))
}

$null = $sb.AppendLine()
$null = $sb.AppendLine("Export-ModuleMember -Function $($publicList -join ',')")
$sb.ToString() | Set-Content (Join-Path $env:BHBuildOutput AutomatedLab.Common\AutomatedLab.Common.psm1)

Copy-Item -Force -Path $env:BHPSModuleManifest -Destination (Join-Path $env:BHBuildOutput AutomatedLab.Common\AutomatedLab.Common.psd1)
Update-ModuleManifest -Path (Join-Path $env:BHBuildOutput AutomatedLab.Common\AutomatedLab.Common.psd1) -FunctionsToExport $publicList
