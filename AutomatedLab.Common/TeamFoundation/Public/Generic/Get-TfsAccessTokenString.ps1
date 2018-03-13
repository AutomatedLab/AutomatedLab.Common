function Get-TfsAccessTokenString
{
    [CmdletBinding()]
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory = $True)]
        [String] $UserName,

        [Parameter(Mandatory = $True)]
        [String] $PersonalAccessToken
    )

    $tokenString = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $UserName,$PersonalAccessToken)))
    return ("Basic {0}" -f $tokenString)
}

Headers     = @{ Authorization = $authorization }
Get-TfsAccessTokenString -UserName japete -PersonalAccessToken c7ceum3sxeezfpx5w5hqylutumlkjc3kb6zzmuws3y64kyhprwfa