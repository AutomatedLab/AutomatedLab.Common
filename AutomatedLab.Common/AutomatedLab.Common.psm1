# Get public and private function definition files.
$modulebase = $PSScriptRoot
$importFolders = Get-ChildItem $modulebase -File -Recurse -ErrorAction SilentlyContinue | Group-Object { $_.Directory.Name } -AsHashTable -AsString

# Types first
foreach ($type in (Get-ChildItem $modulebase/Types/*.cs))
{
    $firstline = Get-Content -TotalCount 1 -Path $type.FullName
    $addTypeParam = @{
        Path           = $type.FullName
        ErrorAction    = 'Stop'
        WarningAction  = 'SilentlyContinue'
        IgnoreWarnings = $true
    }

    if ($firstline.StartsWith('//'))
    {
        $winOnly = $firstline -match 'WindowsOnly'

        if ($winOnly -and ($IsLinux -or $IsMacOS))
        {
            continue
        }

        $null = $firstline -match 'ReferenceAssemblies:(?<Assemblies>[\w:\\,\.]+);?'
        if ($matches.Assemblies)
        {
            $addTypeParam.ReferencedAssemblies = $matches.Assemblies -split ','
        }
    }

    try
    {
        Add-Type @addTypeParam
    }
    catch
    {
        if (-not $_.FullyQualifiedErrorId -like 'TYPE_ALREADY_EXISTS*')
        {
            Write-Warning -Message "Unable to add $($type.BaseName) - Functionality might be impaired.`r`nException was: $($_.Exception.Message), $($_.Exception.LoaderExceptions)"
        }
    }
}

try
{
    [ServerCertificateValidationCallback]::Ignore()
}
catch { }

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
