function Get-PublicIpAddress
{
    [CmdletBinding()]
    param
    ()

    $ipProviderUris = @(
        'https://api.ipify.org?format=json'
        'https://ip.seeip.org/jsonip?'
        'https://api.myip.com'
    )

    foreach ($uri in $ipProviderUris)
    {
        $ip = (Invoke-RestMethod -Method Get -UseBasicParsing -Uri $uri -ErrorAction SilentlyContinue).Ip

        if ($ip)
        {
            return $ip
        }
    }
}
