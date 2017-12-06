function Add-AccountPrivilege
{
    param
    (
        $UserName,
        $Privilege
    )
    
    foreach ($User in $UserName)
    {
        foreach ($Priv in $Privilege)
        {
            [MyLsaWrapper.LsaWrapperCaller]::AddPrivileges($User, $Priv)
            Start-Sleep -Milliseconds 250
            [MyLsaWrapper.LsaWrapperCaller]::AddPrivileges($User, $Priv)
        }
    }
    
}
