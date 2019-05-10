param
(
	[string]
	$SolutionDir
)

$path = Join-Path -Path $SolutionDir -ChildPath Library\bin\debug
$destination = Join-Path -Path $SolutionDir -ChildPath AutomatedLab.Common

$coreClr = Join-Path -Path $path -ChildPath netcoreapp2.2
$fullClr = Join-Path -Path $path -ChildPath net462

if (-not (Test-Path $destination\lib\core))
{
	$null = mkdir $destination\lib\core -Force
}

if (-not (Test-Path $destination\lib\full))
{
	$null = mkdir $destination\lib\full -Force
}

robocopy $coreClr $destination\lib\core *.dll /R:15 /W:5
robocopy $fullClr $destination\lib\full *.dll /R:15 /W:5
