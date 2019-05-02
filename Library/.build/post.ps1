param
(
	[string]
	$SolutionDir
)

$path = Join-Path -Path $SolutionDir -ChildPath Library
$destination = Join-Path -Path $SolutionDir -ChildPath AutomatedLab.Common

$coreClr = Get-ChildItem -Recurse -Filter *.dll -Path $path | Where {$_.FullName -match 'coreapp' }
$fullClr = Get-ChildItem -Recurse -Filter *.dll -Path $path | Where {$_.FullName -notmatch 'coreapp|standard' }

$coreClr | Copy-Item -Destination $destination\lib\core
$fullClr | Copy-Item -Destination $destination\lib\full