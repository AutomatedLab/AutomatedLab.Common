function Install-SoftwarePackage
{
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,
        
        [string]$CommandLine,
        
        [bool]$AsScheduledJob,
        
        [bool]$UseShellExecute,

        [string]$WorkingDirectory,

        [int[]]$ExpectedReturnCodes,

        [system.management.automation.pscredential]$Credential
    )    
    
    #region New-InstallProcess
    function New-InstallProcess
    {
        param(
            [Parameter(Mandatory = $true)]
            [string]$Path,

            [string]$CommandLine,
            
            [bool]$UseShellExecute,

            [string]$WorkingDirectory
        )

        $pInfo = New-Object -TypeName System.Diagnostics.ProcessStartInfo
        $pInfo.FileName = $Path
        if (-not [string]::IsNullOrWhiteSpace($WorkingDirectory)) { $pInfo.WorkingDirectory = $WorkingDirectory }

        $pInfo.UseShellExecute = $UseShellExecute
        if (-not $UseShellExecute)
        {
            $pInfo.RedirectStandardError = $true
            $pInfo.RedirectStandardOutput = $true
        }
        $pInfo.Arguments = $CommandLine

        $p = New-Object -TypeName System.Diagnostics.Process
        $p.StartInfo = $pInfo
        Write-Verbose -Message "Starting process: $($pInfo.FileName) $($pInfo.Arguments)"
        $p.Start() | Out-Null
        Write-Verbose "The installation process ID is $($p.Id)"
        $p.WaitForExit()
        Write-Verbose -Message 'Process exited. Reading output'

        $params = @{
            Process = $p
            LabSourcesConnectOutput = $labSourcesConnectOutput
        }
        if (-not $UseShellExecute)
        {
            $params.Output = $p.StandardOutput.ReadToEnd()
            $params.Error = $p.StandardError.ReadToEnd()
        }
        New-Object -TypeName PSObject -Property $params
    }
    #endregion New-InstallProcess

    #if the path cannot be found and starts with \\automatedlabsources...
    if ((-not (Test-Path -Path $Path) -and $Path -match '\\automatedlabsources[a-z]{5}\.file\.core\.windows\.net'))
    {
        #we assume, the LabSources share was not mapped correctly and try again by calling 'C:\AL\AzureLabSources.ps1'
        $labSourcesConnectOutput = C:\AL\AzureLabSources.ps1 2> $null
        if ($labSourcesConnectOutput.AlternativeLabSourcesPath)
        {
            $Path = $Path.Replace($labSourcesConnectOutput.LabSourcesPath, $labSourcesConnectOutput.AlternativeLabSourcesPath)
        }
    }

    if (-not (Test-Path -Path $Path -PathType Leaf))
    {
        Write-Error "The file '$Path' could not found"
        return        
    }
        
    $start = Get-Date
    Write-Verbose -Message "Starting setup of '$Path' with the following command"
    Write-Verbose -Message "`t$CommandLine"
    Write-Verbose -Message "The timeout is $Timeout minutes, starting at '$start'"
    
    $installationMethod = [System.IO.Path]::GetExtension($Path)
    $installationFile = [System.IO.Path]::GetFileName($Path)
    
    if ($installationMethod -eq '.msi')
    {        
        [string]$CommandLine = if (-not $CommandLine)
        {
            @(
                "/I `"$Path`"", # Install this MSI
                '/QN', # Quietly, without a UI
                "/L*V `"$([System.IO.Path]::GetTempPath())$([System.IO.Path]::GetFileNameWithoutExtension($Path)).log`""     # Verbose output to this log
            )
        }
        else
        {
            '/I "{0}" {1}' -f $Path, $CommandLine # Install this MSI
        }
        
        Write-Verbose -Message 'Installation arguments for MSI are:'
        Write-Verbose -Message "`tPath: $Path"
        Write-Verbose -Message "`tLog File: '`t$([System.IO.Path]::GetTempPath())$([System.IO.Path]::GetFileNameWithoutExtension($Path)).log'"
        
        $Path = 'msiexec.exe'
    }
    elseif ($installationMethod -eq '.msp')
    {
        [string]$CommandLine = if (-not $CommandLine)
        {
            @(
                "/P `"$Path`"", # Install this MSI
                '/QN', # Quietly, without a UI
                "/L*V `"$([System.IO.Path]::GetTempPath())$([System.IO.Path]::GetFileNameWithoutExtension($Path)).log`""     # Verbose output to this log
            )
        }
        else
        {
            '/P {0} {1}' -f $Path, $CommandLine # Install this MSI
        }
        
        Write-Verbose -Message 'Installation arguments for MSI are:'
        Write-Verbose -Message "`tPath: $Path"
        Write-Verbose -Message "`tLog File: '`t$([System.IO.Path]::GetTempPath())$([System.IO.Path]::GetFileNameWithoutExtension($Path)).log'"
        
        $Path = 'msiexec.exe'
    }
    elseif ($installationMethod -eq '.msu')
    {        
        $tempRemoteFolder = [System.IO.Path]::GetTempFileName()
        Remove-Item -Path $tempRemoteFolder
        New-Item -ItemType Directory -Path $tempRemoteFolder
        expand.exe -F:* $Path $tempRemoteFolder
        $Path = 'dism.exe'
        $CommandLine = "/Online /Add-Package /PackagePath:""$tempRemoteFolder"" /NoRestart /Quiet"
    }
    elseif ($installationMethod -eq '.exe')
    { }
    else
    {
        Write-Error -Message 'The extension of the file to install is unknown'
        return
    }

    Write-Verbose -Message "Starting installation of $installationMethod file"

    if ($AsScheduledJob)
    {
        $jobName = "AL_$([guid]::NewGuid())"
        Write-Verbose "In the AsScheduledJob mode, creating scheduled job named '$jobName'"
            
        if ($PSVersionTable.PSVersion -lt '3.0')
        {
            Write-Verbose "Running SCHTASKS.EXE as PowerShell Version is <2.0"
            $processName = [System.IO.Path]::GetFileNameWithoutExtension($Path)
            $d = "{0:HH:mm}" -f (Get-Date).AddMinutes(1)

            "$Path $CommandLine" | Out-File -FilePath "C:\$jobName.cmd" -Encoding default

            if ($Credential)
            {
                SCHTASKS /Create /SC ONCE /ST $d /TN $jobName /RU "$($Credential.UserName)" /RP "$($Credential.GetNetworkCredential().Password)" /TR "C:\$jobName.cmd" | Out-Null
            }
            else
            {
                SCHTASKS /Create /SC ONCE /ST $d /TN $jobName /TR "C:\$jobName.cmd" /RU "SYSTEM" | Out-Null
            }

            Start-Sleep -Seconds 5 #allow some time to let the scheduled task run
            while (-not ($p))
            {
                Start-Sleep -Milliseconds 500
                $p = Get-Process -Name $processName -ErrorAction SilentlyContinue
            }

            $p.WaitForExit()
            Write-Verbose -Message 'Process exited. Reading output'

            $params = @{ Process = $p }
            $params.Add('Output', "Output cannot be retrieved using AsScheduledJob on PowerShell 2.0")
            $params.Add('Error', "Errors cannot be retrieved using AsScheduledJob on PowerShell 2.0")
            New-Object -TypeName PSObject -Property $params
        }
        else
        {
            Write-Verbose "Running Register-ScheduledJob as PowerShell Version is >=3.0"

            $scheduledJobParams = @{
                Name         = $jobName
                ScriptBlock  = (Get-Command -Name New-InstallProcess).ScriptBlock
                ArgumentList = $Path, $CommandLine, $UseShellExecute
                RunNow       = $true
            }
            if ($WorkingDirectory) { $scheduledJobParams.ArgumentList += $WorkingDirectory }
            if ($Credential) { $scheduledJobParams.Add('Credential', $Credential) }
            $scheduledJob = Register-ScheduledJob @scheduledJobParams
            Write-Verbose "ScheduledJob object registered with the ID $($scheduledJob.Id)"
            Start-Sleep -Seconds 5 #allow some time to let the scheduled task run
            
            while (-not $job)
            {
                Start-Sleep -Milliseconds 500
                $job = Get-Job -Name $jobName -ErrorAction SilentlyContinue
            }        
            $job | Wait-Job | Out-Null
            $result = $job | Receive-Job
        }
    }
    else
    {
        $result = New-InstallProcess -Path $Path -CommandLine $CommandLine -UseShellExecute $UseShellExecute -WorkingDirectory $WorkingDirectory
    }
    
    Start-Sleep -Seconds 5
    
    if ($AsScheduledJob)
    {
        if ($PSVersionTable.PSVersion -lt '3.0')
        {
            schtasks.exe /DELETE /TN $jobName /F | Out-Null
            Remove-Item -Path "C:\$jobName.cmd"
        }
        else
        {
            Write-Verbose "Unregistering scheduled job with ID $($scheduledJob.Id)"
            $scheduledJob | Unregister-ScheduledJob
        }
    }

    if ($installationMethod -eq '.msu')
    {
        Remove-Item -Path $tempRemoteFolder -Recurse -Confirm:$false
    }
        
    Write-Verbose "Exit code of installation process is '$($result.Process.ExitCode)'"
    if ($null -ne $result.Process.ExitCode -and (0, 3010 + $ExpectedReturnCodes) -notcontains $result.Process.ExitCode)
    {
        $onLegacyOs = try
        {
            $type = [AutomatedLab.Common.Win32Exception]
            $false
        }
        catch
        { $true }

        if ($onLegacyOs)
        {
            throw (New-Object System.ComponentModel.Win32Exception($result.Process.ExitCode))
        }

        throw (New-Object AutomatedLab.Common.Win32Exception($result.Process.ExitCode))
    }
    else
    {
        Write-Verbose -Message "Installation of '$installationFile' finished successfully"
        $result.Output
    }
}
