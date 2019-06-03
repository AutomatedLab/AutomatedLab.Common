---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-TfsReleaseStep

## SYNOPSIS
Get all possible release steps

## SYNTAX

### Tfs (Default)
```
Get-TfsReleaseStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-UseSsl]
 -Credential <PSCredential> [<CommonParameters>]
```

### VstsName
```
Get-TfsReleaseStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] -FriendlyName <String>
 [-UseSsl] -PersonalAccessToken <String> [<CommonParameters>]
```

### TfsName
```
Get-TfsReleaseStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] -FriendlyName <String>
 [-UseSsl] -Credential <PSCredential> [<CommonParameters>]
```

### VstsHashtable
```
Get-TfsReleaseStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 -FilterHashtable <Hashtable> [-UseSsl] -PersonalAccessToken <String> [<CommonParameters>]
```

### TfsHashtable
```
Get-TfsReleaseStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 -FilterHashtable <Hashtable> [-UseSsl] -Credential <PSCredential> [<CommonParameters>]
```

### VstsScript
```
Get-TfsReleaseStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 -FilterScript <ScriptBlock> [-UseSsl] -PersonalAccessToken <String> [<CommonParameters>]
```

### TfsScript
```
Get-TfsReleaseStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 -FilterScript <ScriptBlock> [-UseSsl] -Credential <PSCredential> [<CommonParameters>]
```

### Vsts
```
Get-TfsReleaseStep -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-UseSsl]
 -PersonalAccessToken <String> [<CommonParameters>]
```

## DESCRIPTION
Get all possible release steps, supports filter scripts

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-TfsReleaseStep -FilterScript {$_.Name -like "*Copy*"} -InstanceName $tfsHostName -Port $tfsPort -CollectionName $collectionName -Credential $tfsCred -UseSsl
```

Gets all release steps where the name contains Copy from an Azure DevOps instance

### Example 2
```powershell
PS C:\> Get-TfsReleaseStep -FriendlyName "Copy files to: Artifacts Share" -InstanceName $tfsHostName -Port $tfsPort -CollectionName $collectionName -Credential $tfsCred -UseSsl
```

Gets all release steps where the friendly name is "Copy files to: Artifacts Share"

## PARAMETERS

### -CollectionName
Your collection

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
Parameter Sets: Tfs, TfsName, TfsHashtable, TfsScript
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterHashtable
Your hashtable filter. Keys should be property names and values the desired property values.

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
Your filter script

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

### -FriendlyName
Friendly name of the release step

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

### -InstanceName
your instance

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
Your personal access token

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

### -Port
The TFS port used

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

### -UseSsl
Indicates if SSL should be used

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
