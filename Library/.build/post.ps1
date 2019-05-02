param
(
	[string]
	$SolutionDir
)

$path = Join-Path -Path $SolutionDir -ChildPath Library
$destination = Join-Path -Path $SolutionDir -ChildPath AutomatedLab.Common

$coreClr = Get-ChildItem -Recurse -Filter *.dll -Path $path | Where {$_.FullName -match 'coreapp' }
$fullClr = Get-ChildItem -Recurse -Filter *.dll -Path $path | Where {$_.FullName -notmatch 'coreapp|standard' }

if (-not (Test-Path ))
{
	$null = mkdir $destination\lib\core
}

if (-not (Test-Path))
{
	$null = mkdir $destination\lib\core
}

$coreClr | Copy-Item -Destination $destination\lib\core
$fullClr | Copy-Item -Destination $destination\lib\full
