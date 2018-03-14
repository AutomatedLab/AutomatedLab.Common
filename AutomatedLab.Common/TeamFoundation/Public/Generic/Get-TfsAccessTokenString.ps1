function Get-TfsAccessTokenString
{
    [CmdletBinding()]
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory = $True)]
        [String] $PersonalAccessToken
    )

    $tokenString = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f '',$PersonalAccessToken)))
    return ("Basic {0}" -f $tokenString)
}
