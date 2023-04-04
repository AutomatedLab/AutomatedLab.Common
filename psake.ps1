# PSake makes variables declared here available in other scriptblocks
# Init some things
Properties {
    # Find the build folder based on build system
    $ProjectRoot = $ENV:BHProjectPath
    if (-not $ProjectRoot)
    {
        $ProjectRoot = $PSScriptRoot
    }

    $Timestamp = Get-date -uformat "%Y%m%d-%H%M%S"
    $PSVersion = $PSVersionTable.PSVersion.Major
    $TestFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"
    $lines = '----------------------------------------------------------------------'
}

Task Default -Depends Deploy

Task Init {
    $lines
    Set-Location $ProjectRoot
    "Build System Details:"
    Get-Item ENV:BH*
    "`n"
}

Task CompileHelpAndModule -Depends Init {
    $lines
    "`n`tSTATUS: Compiling module"
    if ($env:BHBuildSystem -ne 'AppVeyor')
    {
        $projPath = Join-Path $env:BHProjectPath -ChildPath 'Library\Library.csproj' -Resolve -ErrorAction Stop
        dotnet publish $projPath -f net6.0 -o (Join-Path -Path $env:BHBuildOutput 'AutomatedLab.Common\lib\core')
        dotnet publish $projPath -f net462 -o (Join-Path -Path $env:BHBuildOutput 'AutomatedLab.Common\lib\full')
    }
    & (Join-Path $ProjectRoot -ChildPath 'AutomatedLab.Common/.build/build.ps1')
    "`n`tSTATUS: Compiling help content from markdown"
    foreach ($language in (Get-ChildItem -Path (Join-Path $ProjectRoot -ChildPath Help) -Directory))
    {
        $ci = try { [cultureinfo]$language.BaseName} catch { }
        if (-not $ci) {continue}

        New-ExternalHelp -Path $language.FullName -OutputPath (Join-Path $env:BHBuildOutput -ChildPath "AutomatedLab.Common\$($language.BaseName)")
    }
}

Task Test -Depends CompileHelpAndModule {
    $lines
    "`n`tSTATUS: Testing with PowerShell $PSVersion"

    # Run Script Analyzer
    $start = Get-Date
    If ($ENV:BHBuildSystem -eq 'AppVeyor') {Add-AppveyorTest -Name "PsScriptAnalyzer" -Outcome Running}
    $scriptAnalyerResults = Invoke-ScriptAnalyzer -Path (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Recurse -Severity Error -ErrorAction SilentlyContinue
    $end = Get-Date
    if ($scriptAnalyerResults -and $ENV:BHBuildSystem -eq 'AppVeyor')
    {
        Add-AppveyorMessage -Message "PSScriptAnalyzer output contained one or more result(s) with 'Error' severity." -Category Error
        Update-AppveyorTest -Name "PsScriptAnalyzer" -Outcome Failed -ErrorMessage ($scriptAnalyerResults | Out-String) -Duration ([long]($end - $start).TotalMilliSeconds)
    }
    elseif ($ENV:BHBuildSystem -eq 'AppVeyor')
    {
        Update-AppveyorTest -Name "PsScriptAnalyzer" -Outcome Passed -Duration ([long]($end - $start).TotalMilliSeconds)
    }

    # Gather test results. Store them in a variable and file
    $po = [PesterConfiguration]::new()
    $po.Run.Path = "$ProjectRoot\Tests"
    $po.TestResult.Enabled = $true
    $po.TestResult.OutputFormat = 'NUnitXml'
    $po.TestResult.OutputPath = "$ProjectRoot\$TestFile"
    $po.Run.PassThru = $true
    $TestResults = Invoke-Pester -Configuration $po

    # In Appveyor?  Upload our tests! #Abstract this into a function?
    If ($ENV:BHBuildSystem -eq 'AppVeyor')
    {
        (New-Object 'System.Net.WebClient').UploadFile(
            "https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)",
            "$ProjectRoot\$TestFile" )
    }

    Remove-Item "$ProjectRoot\$TestFile" -Force -ErrorAction SilentlyContinue

    # Failed tests?
    # Need to tell psake or it will proceed to the deployment. Danger!
    if ($TestResults.FailedCount -gt 0)
    {
        Write-Error "Failed '$($TestResults.FailedCount)' tests, build failed"
    }
    "`n"
}

Task Build -Depends Test {
    $lines

    Import-Module -Force (Join-Path -Path $env:BHBuildOutput -ChildPath AutomatedLab.Common\AutomatedLab.Common.psd1)

    # Bump the module version
    if ($env:APPVEYOR_BUILD_VERSION)
    {
        Update-Metadata -Path (Join-Path -Path $env:BHBuildOutput -ChildPath AutomatedLab.Common\AutomatedLab.Common.psd1) -Verbose -Value $env:APPVEYOR_BUILD_VERSION
    }
}

Task Deploy -Depends Build {
    $lines
    "Starting deployment with files inside $(Join-Path $ProjectRoot publish)"

    $Params = @{
        Path    = $ENV:BHProjectPath
        Force   = $true
        Recurse = $false # We keep psdeploy artifacts, avoid deploying those : )
        Verbose = $true
    }
    Invoke-PSDeploy @Params
}