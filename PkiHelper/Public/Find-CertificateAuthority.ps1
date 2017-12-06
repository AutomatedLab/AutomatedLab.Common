function Find-CertificateAuthority
{
    # .ExternalHelp AutomatedLab.Help.xml
    [cmdletBinding()]
    param(
        [string]$DomainName
    )
    
    try
    {
        if (-not $DomainName)
        {
            $DomainName = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().GetDirectoryEntry().distinguishedName
        }
        else
        {
            $ctx = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Domain', $DomainName)
            $DomainName = [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($ctx).GetDirectoryEntry().distinguishedName
        }
        $cdpContainer = [ADSI]"LDAP://CN=CDP,CN=Public Key Services,CN=Services,CN=Configuration,$DomainName"
    }
    catch
    {
        Write-Error "The domain '$DomainName' could not be contacted" -TargetObject $DomainName
        return
    }
                
    $caFound = $false
    foreach ($item in $cdpContainer.Children)
    {
        if (-not $caFound)
        {
            $machine = ($item.distinguishedName -split '=|,')[1]
            $caName = ($item.Children.distinguishedName -split '=|,')[1]
                        
            $certificateAuthority = "$machine\$caName"
                        
            $result = certutil.exe -ping $certificateAuthority
            if ($result -match 'interface is alive*' )
            {
                $caFound = $true
            }
        }
    }
    
    if ($caFound)
    {
        $certificateAuthority
    }
    else
    {
        Write-Error "No Certificate Authority could be found in domain '$DomainName'"
    }
}
