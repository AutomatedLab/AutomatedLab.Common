function Get-CATemplate
{
    [cmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$TemplateName
    )

    $configNc = ([adsi]'LDAP://RootDSE').configurationNamingContext
    $templateContainer = [adsi]"LDAP://CN=Certificate Templates,CN=Public Key Services,CN=Services,$configNc"
    Write-Verbose "Template container is '$($templateContainer.distinguishedName)'"

    $templateContainer.Children | Where-Object Name -eq $TemplateName
}
