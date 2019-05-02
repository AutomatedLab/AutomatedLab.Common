param
(
	[string]
	$SolutionDir
)

$path = Join-Path -Path $SolutionDir -ChildPath Library
$destination = Join-Path -Path $SolutionDir -ChildPath AutomatedLab.Common

$coreClr = Get-ChildItem -Recurse -Filter *.dll -Path $path | Where {$_.FullName -match 'coreapp' }
$fullClr = Get-ChildItem -Recurse -Filter *.dll -Path $path | Where {$_.FullName -notmatch 'coreapp|standard' }

if (-not (Test-Path $destination\lib\core))
{
	$null = mkdir $destination\lib\core -Force
}

if (-not (Test-Path $destination\lib\full))
{
	$null = mkdir $destination\lib\full-Force
}

$coreClr | Copy-Item -Destination $destination\lib\core
$fullClr | Copy-Item -Destination $destination\lib\full
