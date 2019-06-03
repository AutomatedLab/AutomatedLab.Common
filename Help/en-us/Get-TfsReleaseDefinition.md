---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-TfsReleaseDefinition

## SYNOPSIS

Get one or more TFS/Azure DevOps Release Definitions

## SYNTAX

### Cred (Default)
```
Get-TfsReleaseDefinition -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 [-ApiVersion <String>] -ProjectName <String> [-UseSsl] -Credential <PSCredential> [<CommonParameters>]
```

### Pat
```
Get-TfsReleaseDefinition -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 [-ApiVersion <String>] -ProjectName <String> [-UseSsl] -PersonalAccessToken <String> [<CommonParameters>]
```

## DESCRIPTION

Get one or more TFS/Azure DevOps Release Definitions

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-TfsReleaseDefinition -InstanceName 'dsc1tfs1' -CollectionName automatedlab -ProjectName somenewname -Credential $cred
```

Returns the release pipeline for the project somenewname

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
Your collection name

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
Your credential

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

### -InstanceName
Your instance name

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
Your personal access token, if not using a credential

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

### -Port
The port of your TFS/Azure DevOps Server installation

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

### -ProjectName
Your project name

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

### -UseSsl
Indicates if SSL should be used to connect

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
