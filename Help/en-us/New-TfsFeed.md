---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# New-TfsFeed

## SYNOPSIS
Creates a new feed

## SYNTAX

### NameCred (Default)
```
New-TfsFeed -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -FeedName <String> [-Description <String>] [-UseSsl] -Credential <PSCredential> [-Timeout <TimeSpan>]
 [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### GuidCred
```
New-TfsFeed -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -FeedName <String> [-Description <String>] [-UseSsl] -Credential <PSCredential> [-Timeout <TimeSpan>]
 [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### GuidPat
```
New-TfsFeed -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -FeedName <String> [-Description <String>] [-UseSsl] -PersonalAccessToken <String> [-Timeout <TimeSpan>]
 [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### NamePat
```
New-TfsFeed -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -FeedName <String> [-Description <String>] [-UseSsl] -PersonalAccessToken <String> [-Timeout <TimeSpan>]
 [-SkipCertificateCheck] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new feed

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ApiVersion
{{ Fill ApiVersion Description }}

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
{{ Fill CollectionName Description }}

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
{{ Fill Credential Description }}

```yaml
Type: PSCredential
Parameter Sets: NameCred, GuidCred
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
{{ Fill Description Description }}

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

### -FeedName
{{ Fill FeedName Description }}

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

### -InstanceName
{{ Fill InstanceName Description }}

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
{{ Fill PersonalAccessToken Description }}

```yaml
Type: String
Parameter Sets: GuidPat, NamePat
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
{{ Fill Port Description }}

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
{{ Fill SkipCertificateCheck Description }}

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

### -Timeout
{{ Fill Timeout Description }}

```yaml
Type: TimeSpan
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSsl
{{ Fill UseSsl Description }}

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
