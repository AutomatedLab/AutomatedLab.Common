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

Task CompileHelp -Depends Init {
    $lines
    "`n`tSTATUS: Compiling help content from markdown"
    New-ExternalHelp -Path (Join-Path $ProjectRoot -ChildPath Help) -OutputPath (Join-Path $ProjectRoot -ChildPath $ENV:BHProjectName)
}

Task Test -Depends CompileHelp {
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
    $TestResults = Invoke-Pester -Path $ProjectRoot\Tests -PassThru -OutputFormat NUnitXml -OutputFile "$ProjectRoot\$TestFile"

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
    
    # Load the module, read the exported functions, update the psd1 FunctionsToExport
    Set-ModuleFunctions -Verbose

    # Bump the module version
    Update-Metadata -Path $env:BHPSModuleManifest -Verbose -Value $env:APPVEYOR_BUILD_VERSION
}

Task Deploy -Depends Build {
    $lines
    "Starting deployment with files inside $ProjectRoot"

    $Params = @{
        Path    = $ProjectRoot
        Force   = $true
        Recurse = $false # We keep psdeploy artifacts, avoid deploying those : )
        Verbose = $true
    }
    Invoke-PSDeploy @Params
}