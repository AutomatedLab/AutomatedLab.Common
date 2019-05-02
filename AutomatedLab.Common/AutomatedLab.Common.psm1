# Get public and private function definition files.
$importFolders = Get-ChildItem $PSScriptRoot -File -Recurse -ErrorAction SilentlyContinue | Group-Object { $_.Directory.Name } -AsHashTable -AsString

# Types first
try
{
    if ($PSEdition -eq 'Core')
    {
        Add-Type -Path $PSScriptRoot\lib\core\AutomatedLab.Common.dll -ErrorAction Stop
    }
    else
    {
        Add-Type -Path $PSScriptRoot\lib\full\AutomatedLab.Common.dll -ErrorAction Stop
    }
}
catch
{
    Write-Warning -Message "Unable to add AutomatedLab.Common.dll - GPO and PKI functionality might be impaired."
}

# Dot source the files
foreach ($import in @($importFolders.Public + $importFolders.Private))
{
    if ($null -eq $import) { continue }
    Try
    {
        . $import.FullName
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.FullName): $_"
    }
}

Export-ModuleMember -Function $importFolders.Public.Basename
