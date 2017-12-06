function Add-AccountPrivilege
{
    param
    (
        [Parameter(Mandatory = $true)]
        [string[]]
        $UserName,

        [validateSet('SeNetworkLogonRight', 
            'SeRemoteInteractiveLogonRight', 
            'SeBatchLogonRight', 
            'SeInteractiveLogonRight', 
            'SeServiceLogonRight', 
            'SeDenyNetworkLogonRight', 
            'SeDenyInteractiveLogonRight', 
            'SeDenyBatchLogonRight', 
            'SeDenyServiceLogonRight', 
            'SeDenyRemoteInteractiveLogonRight', 
            'SeTcbPrivilege', 
            'SeMachineAccountPrivilege', 
            'SeIncreaseQuotaPrivilege', 
            'SeBackupPrivilege', 
            'SeChangeNotifyPrivilege', 
            'SeSystemTimePrivilege', 
            'SeCreateTokenPrivilege', 
            'SeCreatePagefilePrivilege', 
            'SeCreateGlobalPrivilege', 
            'SeDebugPrivilege', 
            'SeEnableDelegationPrivilege', 
            'SeRemoteShutdownPrivilege', 
            'SeAuditPrivilege', 
            'SeImpersonatePrivilege', 
            'SeIncreaseBasePriorityPrivilege', 
            'SeLoadDriverPrivilege', 
            'SeLockMemoryPrivilege', 
            'SeSecurityPrivilege', 
            'SeSystemEnvironmentPrivilege', 
            'SeManageVolumePrivilege', 
            'SeProfileSingleProcessPrivilege', 
            'SeSystemProfilePrivilege', 
            'SeUndockPrivilege', 
            'SeAssignPrimaryTokenPrivilege', 
            'SeRestorePrivilege', 
            'SeShutdownPrivilege', 
            'SeSynchAgentPrivilege', 
            'SeTakeOwnershipPrivilege' 
        )]
        [string[]]
        $Privilege
    )    
    
    $lsaWrapper = New-Object -TypeName MyLsaWrapper.LsaWrapper -ErrorAction Stop

    foreach ($User in $UserName)
    {
        foreach ($Priv in $Privilege)
        {
            $lsaWrapper.AddPrivileges($User, $Priv)
            Start-Sleep -Milliseconds 250
            $lsaWrapper.AddPrivileges($User, $Priv)
        }
    }    
}
