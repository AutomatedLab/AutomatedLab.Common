---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-TfsBuildStep

## SYNOPSIS
Gets all available build steps

## SYNTAX

### Tfs (Default)
```
Get-TfsBuildStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-UseSsl]
 -Credential <PSCredential> [<CommonParameters>]
```

### VstsName
```
Get-TfsBuildStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] -FriendlyName <String>
 [-UseSsl] -PersonalAccessToken <String> [<CommonParameters>]
```

### TfsName
```
Get-TfsBuildStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] -FriendlyName <String>
 [-UseSsl] -Credential <PSCredential> [<CommonParameters>]
```

### VstsHashtable
```
Get-TfsBuildStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 -FilterHashtable <Hashtable> [-UseSsl] -PersonalAccessToken <String> [<CommonParameters>]
```

### TfsHashtable
```
Get-TfsBuildStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 -FilterHashtable <Hashtable> [-UseSsl] -Credential <PSCredential> [<CommonParameters>]
```

### VstsScript
```
Get-TfsBuildStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] -FilterScript <ScriptBlock>
 [-UseSsl] -PersonalAccessToken <String> [<CommonParameters>]
```

### TfsScript
```
Get-TfsBuildStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] -FilterScript <ScriptBlock>
 [-UseSsl] -Credential <PSCredential> [<CommonParameters>]
```

### Vsts
```
Get-TfsBuildStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-UseSsl]
 -PersonalAccessToken <String> [<CommonParameters>]
```

## DESCRIPTION
Gets all available build steps in a copy-pasteable format that can be copied to a script.
Since there are a mulitude of available steps, you can filter on their names, apply a filter hashtable or filter via a script block.

## EXAMPLES

### Get all build steps
@{paragraph=PS C:\\\>}

```
Get-TfsBuildStep -InstanceName 'dsc1tfs1' -CollectionName AutomatedLab -Credential (Get-Credential)
```

### Filter build steps
@{paragraph=PS C:\\\>}

```
Get-TfsBuildStep -InstanceName 'dsc1tfs1' -CollectionName AutomatedLab -FriendlyName *copy* -Credential (Get-Credential)
```

## PARAMETERS

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

### -FriendlyName
The friendly name of the build step.
Accepts wildcard characters

```yaml
Type: String
Parameter Sets: VstsName, TfsName
Aliases:

Required: True
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

### -PersonalAccessToken
The VSTS access token as returned by Get-TfsAccessTokenString

```yaml
Type: String
Parameter Sets: VstsName, VstsHashtable, VstsScript, Vsts
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
The TFS credential to use

```yaml
Type: PSCredential
Parameter Sets: Tfs, TfsName, TfsHashtable, TfsScript
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterHashtable
The filter hashtable that can be applied to the result set.
Accepts the following hashtable keys: friendlyName, description, category, definitionType, author
Values may contain wildcards.

```yaml
Type: Hashtable
Parameter Sets: VstsHashtable, TfsHashtable
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterScript
The script block to filter the output on.
Use the following properties to filter with $_ or $PSItem

visibility: enum (Build,Release)
id: \[guid\]
name: \[string\]
version: \[psobject\] with Major, Minor, Patch
serverOwned: \[bool\]
contentsUploaded: \[bool\]
iconUrl: \[string\]
hostType: \[string\]
friendlyName: \[string\]
description: \[string\]
category: \[string
helpMarkDown: \[string\]
definitionType: \[string\]
author: \[string\]
demands: \[string\[\]\] # List of dependencies

```yaml
Type: ScriptBlock
Parameter Sets: VstsScript, TfsScript
Aliases:

Required: True
Position: Named
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
