---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Add-CATemplateStandardPermission

## SYNOPSIS

This cmdlet enables standard permissions on a CA Template

## SYNTAX

```
Add-CATemplateStandardPermission [-TemplateName] <String> [-SamAccountName] <String[]> [<CommonParameters>]
```

## DESCRIPTION

This cmdlet enables the Read, Enroll and AutoEnroll permissions on one template for one or more accounts

## EXAMPLES

### Example 1
```powershell
PS C:\> Add-CATemplateStandardPermission -TemplateName WebServer1 -SamAccountName 'Domain Computers'
```

Gives members of the group Domain Computers the permission to Enroll and AutoEnroll for the template WebServer1

## PARAMETERS

### -TemplateName

The name of the template for which permissions will be added.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SamAccountName

The list of accounts (users, computers, groups) that will receive Read, Enroll and AutoEnroll permissions

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
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
