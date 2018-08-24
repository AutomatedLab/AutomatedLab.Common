function Publish-CaTemplate
{
    [cmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$TemplateName
    )
    
    $ca = Find-CertificateAuthority
    $caInfo = certutil.exe -CAInfo -Config $ca
    if ($caInfo -like '*No local Certification Authority*')
    {
        Write-Error 'No issuing CA found in the machines domain'
        return
    }
    $computerName = $ca.Split('\')[0]

    $start = Get-Date
    $done = $false
    $i = 0
    do
    {
        Write-Verbose -Message "Trying to publish '$TemplateName' on '$ca' at ($(Get-Date)), retry count $i"
        certutil.exe -Config $ca -SetCAtemplates "+$TemplateName" | Out-Null
        if (-not $LASTEXITCODE)
        {
            $done = $true
        }
        else
        {
            if ($i % 5 -eq 0)
            {
                Get-Service -Name CertSvc -ComputerName $computerName | Restart-Service
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
