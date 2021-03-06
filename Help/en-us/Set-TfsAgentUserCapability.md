---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Set-TfsAgentUserCapability

## SYNOPSIS
Sets (replaces) capabilities on an existing build agent

## SYNTAX

### PatId
```
Set-TfsAgentUserCapability -InstanceName <String> [-CollectionName <String>] -PoolName <String>
 -AgentId <UInt16> [-Port <UInt32>] [-ApiVersion <String>] [-UseSsl] -PersonalAccessToken <String>
 [-SkipCertificateCheck] -Capability <Hashtable> [<CommonParameters>]
```

### CredId
```
Set-TfsAgentUserCapability -InstanceName <String> [-CollectionName <String>] -PoolName <String>
 -AgentId <UInt16> [-Port <UInt32>] [-ApiVersion <String>] [-UseSsl] -Credential <PSCredential>
 [-SkipCertificateCheck] -Capability <Hashtable> [<CommonParameters>]
```

### PatObject
```
Set-TfsAgentUserCapability -InstanceName <String> [-CollectionName <String>] -PoolName <String> -Agent <Object>
 [-Port <UInt32>] [-ApiVersion <String>] [-UseSsl] -PersonalAccessToken <String> [-SkipCertificateCheck]
 -Capability <Hashtable> [<CommonParameters>]
```

### CredObject
```
Set-TfsAgentUserCapability -InstanceName <String> [-CollectionName <String>] -PoolName <String> -Agent <Object>
 [-Port <UInt32>] [-ApiVersion <String>] [-UseSsl] -Credential <PSCredential> [-SkipCertificateCheck]
 -Capability <Hashtable> [<CommonParameters>]
```

## DESCRIPTION
Sets (replaces) capabilities on an existing build agent. All user capabilities, that have not been included
with the Capability dictionary will be removed.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-TfsAgentUserCapability -InstanceName AL -CollectionName ALProject1 -PoolName Sharknado -AgentId 1 -Capability @{Cap1 = 'Value1'}
```

On the agent with ID 1, set the user-defined capabilities to Cap1 = Value1, removing all other user-defined capabilities.

## PARAMETERS

### -Agent
An agent object, retrieved with Get-TfsAgent

```yaml
Type: Object
Parameter Sets: PatObject, CredObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AgentId
The ID of an agent, for example retrieved with Get-TfsAgent

```yaml
Type: UInt16
Parameter Sets: PatId, CredId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApiVersion
The API version to use. Capabilites require 5.1+

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Capability
The dictionary of capabilities to set

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CollectionName
Your collection.
Defaults to DefaultCollection

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
The TFS credential to use

```yaml
Type: PSCredential
Parameter Sets: CredId, CredObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceName
The instance name (dev.azure.com/username or your TFS host name)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersonalAccessToken
The VSTS access token as returned by Get-TfsAccessTokenString

```yaml
Type: String
Parameter Sets: PatId, PatObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PoolName
The name of the pool your agent is associated with

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
The port of your installation/VSTS instance

```yaml
Type: UInt32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCertificateCheck
Skip certificate validation

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSsl
Indicates that SSL should be used

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
