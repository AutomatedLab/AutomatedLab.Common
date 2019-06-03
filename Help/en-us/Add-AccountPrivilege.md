---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Add-AccountPrivilege

## SYNOPSIS
Enable one or more privileges for an account

## SYNTAX

```
Add-AccountPrivilege [-UserName] <String[]> [[-Privilege] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Can be used to enable one of the following privileges for one or more users:
'SeNetworkLogonRight', 
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

## EXAMPLES

### Add CreateProcessToken rights

```powershell
PS C:\> Add-AccountPrivilege -UserName greedyAccount@contoso.com -Privilege SeImpersonatePrivilege
```

Enables the Impersonate privilege

## PARAMETERS

### -UserName
The list of user names that will receive the privileges

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Privilege
The list of privileges to add

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
