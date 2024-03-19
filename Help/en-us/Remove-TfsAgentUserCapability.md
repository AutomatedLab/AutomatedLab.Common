---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Remove-TfsAgentUserCapability

## SYNOPSIS
Removes capabilities from an existing build agent

## SYNTAX

### PatId
```
Remove-TfsAgentUserCapability -InstanceName <String> [-CollectionName <String>] -PoolName <String>
 -AgentId <UInt16> [-Port <UInt32>] [-ApiVersion <String>] [-UseSsl] -PersonalAccessToken <String>
 [-SkipCertificateCheck] -Capability <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CredId
```
Remove-TfsAgentUserCapability -InstanceName <String> [-CollectionName <String>] -PoolName <String>
 -AgentId <UInt16> [-Port <UInt32>] [-ApiVersion <String>] [-UseSsl] -Credential <PSCredential>
 [-SkipCertificateCheck] -Capability <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PatObject
```
Remove-TfsAgentUserCapability -InstanceName <String> [-CollectionName <String>] -PoolName <String>
 -Agent <Object> [-Port <UInt32>] [-ApiVersion <String>] [-UseSsl] -PersonalAccessToken <String>
 [-SkipCertificateCheck] -Capability <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CredObject
```
Remove-TfsAgentUserCapability -InstanceName <String> [-CollectionName <String>] -PoolName <String>
 -Agent <Object> [-Port <UInt32>] [-ApiVersion <String>] [-UseSsl] -Credential <PSCredential>
 [-SkipCertificateCheck] -Capability <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes capabilities from an existing build agent

## EXAMPLES

### Example 1
```
PS C:\> Remove-TfsAgentUserCapability -InstanceName AL -CollectionName ALProject1 -PoolName Sharknado -AgentId 1 -Capability Cap1, Cap2
```

On the agent with ID 1, remove the user-defined capabilities Cap1 and Cap2

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
The API version to use.
Capabilites require 5.1+

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
The list of capabilities to remove

```yaml
Type: String[]
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
Default value: False
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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

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
