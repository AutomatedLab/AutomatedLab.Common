function Publish-CATemplate
{
    # .ExternalHelp AutomatedLab.Help.xml
    [cmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$TemplateName
    )
    
    $caInfo = certutil.exe -CAInfo
    if ($caInfo -like '*No local Certification Authority*')
    {
        Write-Error 'This command needs to run on a CA'
        return
    }

    $start = Get-Date
    $done = $false
    $i = 0
    do
    {
        Write-Verbose -Message "Trying to publish '$TemplateName' at ($(Get-Date)), retry count $i"
        $result = certutil.exe -SetCAtemplates "+$TemplateName" | Out-Null
        if (-not $LASTEXITCODE)
        {
            $done = $true
        }
        else
        {
            if ($i % 5 -eq 0)
            {
                Restart-Service -Name CertSvc
            }

            $ex = New-Object System.ComponentModel.Win32Exception($LASTEXITCODE)
            Write-Verbose -Message "Publishing the template '$TemplateName' failed: $($ex.Message)"

            Start-Sleep -Seconds 10
            $i++
        }
    }
    until ($done -or ((Get-Date) - $start).TotalMinutes -ge 10)
    Write-Verbose -Message "Certificate templete '$TemplateName' published successfully"

    if ($LASTEXITCODE)
    {
        $ex = New-Object System.ComponentModel.Win32Exception($LASTEXITCODE)
        Write-Error -Message "Publishing the template '$TemplateName' failed: $($ex.Message)" -Exception $ex
        return
    }

    Write-Verbose "Successfully published template '$TemplateName'"
}
