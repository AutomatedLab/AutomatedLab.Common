# Get public and private function definition files.
$moduleName = ([System.IO.Path]::GetFileNameWithoutExtension($PSCommandPath) -split '\.')[-1]
$types = @( Get-ChildItem -Path $PSScriptRoot\$moduleName\Types\*.ps1 -ErrorAction SilentlyContinue)
$public = @( Get-ChildItem -Path $PSScriptRoot\$moduleName\Public\*.ps1 -ErrorAction SilentlyContinue )
$private = @( Get-ChildItem -Path $PSScriptRoot\$moduleName\Private\*.ps1 -ErrorAction SilentlyContinue )

# Types first
foreach ( $type in $types)
{
    . $type.FullName
}

# Dot source the files
foreach ($import in @($public + $private))
{
    Try
    {
        . $import.FullName
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.FullName): $_"
    }
}

Export-ModuleMember -Function $public.Basename
