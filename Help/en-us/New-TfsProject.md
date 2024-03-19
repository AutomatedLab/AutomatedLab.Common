---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# New-TfsProject

## SYNOPSIS
Create a new team project

## SYNTAX

### NameCred (Default)
```
New-TfsProject -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -ProjectName <String> [-ProjectDescription <String>] [-SourceControlType <Object>] -TemplateName <String>
 [-UseSsl] -Credential <PSCredential> [-Timeout <TimeSpan>] [-SkipCertificateCheck] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### GuidCred
```
New-TfsProject -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -ProjectName <String> [-ProjectDescription <String>] [-SourceControlType <Object>] -TemplateGuid <Guid>
 [-UseSsl] -Credential <PSCredential> [-Timeout <TimeSpan>] [-SkipCertificateCheck] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### GuidPat
```
New-TfsProject -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -ProjectName <String> [-ProjectDescription <String>] [-SourceControlType <Object>] -TemplateGuid <Guid>
 [-UseSsl] -PersonalAccessToken <String> [-Timeout <TimeSpan>] [-SkipCertificateCheck] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### NamePat
```
New-TfsProject -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -ProjectName <String> [-ProjectDescription <String>] [-SourceControlType <Object>] -TemplateName <String>
 [-UseSsl] -PersonalAccessToken <String> [-Timeout <TimeSpan>] [-SkipCertificateCheck] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new team project

## EXAMPLES

### Example 1
```
New-TfsProject -InstanceName DSCTFS -Port 443 -CollectionName 'AutomatedLab' -ProjectName 'DSC' -Credential $credential -UseSsl -SourceControlType Git -TemplateName 'Agile'
```

This sample creates a new project called DSC that uses git as the source code management and an Agile process template

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
The TFS credential to use

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
Parameter Sets: GuidPat, NamePat
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

### -ProjectDescription
The project description

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

### -ProjectName
The name of your team project

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

### -SourceControlType
The source control type to use (Git, Tfvc).
Defaults to Git

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateGuid
The process template GUID, refer to Get-TfsProcessTemplate

```yaml
Type: Guid
Parameter Sets: GuidCred, GuidPat
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateName
The process template name, refer to Get-TfsProcessTemplate

```yaml
Type: String
Parameter Sets: NameCred, NamePat
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timeout
The timeout for project creation

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

## OUTPUTS

## NOTES

## RELATED LINKS
