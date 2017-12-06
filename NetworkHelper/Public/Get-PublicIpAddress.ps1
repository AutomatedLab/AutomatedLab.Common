function Get-PublicIpAddress
{
    [CmdletBinding()]
    param
    ()

    $ipProviderUris = @(
        'http://myip.dnsomatic.com/'
        'http://ip4.host/'
        'http://www.whatismypublicip.com'
    )

    foreach ($uri in $ipProviderUris)
    {
        $Matches = $null

        if ((Invoke-WebRequest -URI $uri).Content -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}')
        {
            return $Matches[0]
        }
    }
}
