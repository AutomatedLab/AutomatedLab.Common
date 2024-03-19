---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-TfsGitRepository

## SYNOPSIS
Gets a project's repository

## SYNTAX

### Tfs
```
Get-TfsGitRepository -InstanceName <String> -CollectionName <String> [-Port <UInt32>] [-ApiVersion <String>]
 [-ProjectName <String>] [-UseSsl] [-Credential <PSCredential>] [-SkipCertificateCheck] [<CommonParameters>]
```

### Vsts
```
Get-TfsGitRepository -InstanceName <String> -CollectionName <String> [-Port <UInt32>] [-ApiVersion <String>]
 [-ProjectName <String>] [-UseSsl] [-PersonalAccessToken <String>] [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Gets a project's repository

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

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
Parameter Sets: Tfs
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
Parameter Sets: Vsts
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

### -ProjectName
The name of your team project

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

## OUTPUTS

## NOTES

## RELATED LINKS
