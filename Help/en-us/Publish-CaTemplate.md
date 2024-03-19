---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Publish-CaTemplate

## SYNOPSIS
Publish a certificate template

## SYNTAX

```
Publish-CaTemplate [-TemplateName] <String> [<CommonParameters>]
```

## DESCRIPTION
Publish a certificate template, e.g.
after creating it with New-CaTemplate

## EXAMPLES

### Example 1
```
PS C:\> Publish-CaTemplate -TemplateName WebServerCustom
```

Publishes the template WebServerCustom on the CA

## PARAMETERS

### -TemplateName
Name of the template to publish

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
