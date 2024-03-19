# Get public and private function definition files.
$modulebase = $PSScriptRoot
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