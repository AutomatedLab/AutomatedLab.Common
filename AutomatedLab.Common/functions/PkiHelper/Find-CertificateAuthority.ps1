function Find-CertificateAuthority
{
    [cmdletBinding()]
    param(
        [string]$DomainName
    )

    Add-Type -AssemblyName System.DirectoryServices.AccountManagement

    try
    {
        $ctx = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('Domain', $DomainName)
    }
    catch
    {
        Write-Error "The domain '$DomainName' could not be contacted"
        return
    }

    try
    {
        $configDn = ([ADSI]'LDAP://RootDSE').configurationNamingContext
        $cdpContainer = [ADSI]"LDAP://CN=CDP,CN=Public Key Services,CN=Services,$configDn"

        if (-not $cdpContainer)
        {
            Write-Error 'Could not connect to CDP container' -ErrorAction Stop
        }
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

            if ($DomainName)
            {
                $group = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($ctx, 'Cert Publishers')
                $machine = $group.Members | Where-Object Name -eq $machine
                if ($machine.Context.Name -ne $DomainName)
                {
                    continue
                }
            }

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
