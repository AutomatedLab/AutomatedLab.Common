---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-TfsAgent

## SYNOPSIS
Get agents from an agent pool

## SYNTAX

### Cred
```
Get-TfsAgent -InstanceName <String> [-CollectionName <String>] -PoolName <String> [-Port <UInt32>]
 [-ApiVersion <String>] [-UseSsl] -Credential <PSCredential> [-SkipCertificateCheck] [-Filter <ScriptBlock>]
 [<CommonParameters>]
```

### Pat
```
Get-TfsAgent -InstanceName <String> [-CollectionName <String>] -PoolName <String> [-Port <UInt32>]
 [-ApiVersion <String>] [-UseSsl] -PersonalAccessToken <String> [-SkipCertificateCheck] [-Filter <ScriptBlock>]
 [<CommonParameters>]
```

## DESCRIPTION
Get agents from an agent pool, filterable on all properties of an agent (including its capabilities)

## EXAMPLES

### Example 1
```
PS C:\> Get-TfsAgent -InstanceName AL -CollectionName ALProject1 -PoolName Sharknado
```

Retrieve all agents in the Sharknado pool

### Example 2
```
PS C:\> Get-TfsAgent -InstanceName AL -CollectionName ALProject1 -PoolName Sharknado -Filter {$_.name -eq 'BLD01'}
```

Retrieve agent BLD01 in the Sharknado pool

## PARAMETERS

### -ApiVersion
The API version to use.
Refer to https://www.visualstudio.com/en-us/docs/integrate/api/overview for details

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
The instance name (dev.azure.com/username or your TFS host name)

```yaml
Type: PSCredential
Parameter Sets: Cred
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
ScriptBlock filter on all agent properties

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
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
Parameter Sets: Pat
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
