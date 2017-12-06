function Add-CATemplateStandardPermission
{
    # .ExternalHelp AutomatedLab.Help.xml
    [cmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$TemplateName,
        
        [Parameter(Mandatory = $true)]
        [string[]]$SamAccountName
    )
    
    $configNc= ([adsi]'LDAP://RootDSE').configurationNamingContext
    $templateContainer = [adsi]"LDAP://CN=Certificate Templates,CN=Public Key Services,CN=Services,$configNc"
    Write-Verbose "Template container is '$templateContainer'"

    $template = $templateContainer.Children | Where-Object Name -eq $TemplateName
    if (-not $template)
    {
        Write-Error "The template '$TemplateName' could not be found"
        return
    }
   
    foreach ($name in $SamAccountName)
    {
        try
        {
            $sid = ([System.Security.Principal.NTAccount]$name).Translate([System.Security.Principal.SecurityIdentifier])
            $name = $sid.Translate([System.Security.Principal.NTAccount])

            dsacls $template.DistinguishedName /G "$($name):GR"
            dsacls $template.DistinguishedName /G "$($name):CA;Enroll"
            dsacls $template.DistinguishedName /G "$($name):CA;AutoEnrollment"
        }
        catch
        {
            Write-Error "The principal '$name' could not be found"
        }
    }
}
