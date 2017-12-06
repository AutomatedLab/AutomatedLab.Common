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
