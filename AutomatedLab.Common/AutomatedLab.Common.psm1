# Get public and private function definition files.
$modulebase =  $PSScriptRoot

$script:hostFilePath = if ($PSEdition -eq 'Desktop' -or $IsWindows)
{
    "$($env:SystemRoot)\System32\drivers\etc\hosts"
}
elseif ($PSEdition -eq 'Core' -and $IsLinux)
{
    '/etc/hosts'
}

# Types first
$typeExists = try { [AutomatedLab.Common.Win32Exception] }catch { }
if (-not $typeExists)
{
    try
    {
        if ($PSEdition -eq 'Core')
        {
            Add-Type -Path $modulebase/lib/core/AutomatedLab.Common.dll -ErrorAction Stop
        }
        else
        {
            Add-Type -Path $modulebase/lib/full/AutomatedLab.Common.dll -ErrorAction Stop
        }
    }
    catch
    {
        Write-Warning -Message "Unable to add AutomatedLab.Common.dll - GPO and PKI functionality might be impaired.`r`nException was: $($_.Exception.Message), $($_.Exception.LoaderExceptions)"
    }
}

try
{
    [ServerCertificateValidationCallback]::Ignore()
}
catch { }

$importFolders = Get-ChildItem $modulebase -File -Recurse -ErrorAction SilentlyContinue | Group-Object { $_.Directory.Name } -AsHashTable -AsString

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
