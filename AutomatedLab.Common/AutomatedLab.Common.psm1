# Get public and private function definition files.
$importFolders = Get-ChildItem $PSScriptRoot -File -Recurse -ErrorAction SilentlyContinue | Group-Object {$_.Directory.Name} -AsHashTable -AsString

# Types first
foreach ( $type in $importFolders.Types)
{
    . $type.FullName
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
