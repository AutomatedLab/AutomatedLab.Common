---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Test-CATemplate

## SYNOPSIS
Test if a certificate template exists

## SYNTAX

```
Test-CATemplate [-TemplateName] <String> [<CommonParameters>]
```

## DESCRIPTION
Test if a certificate template exists

## EXAMPLES

### Example 1
```
PS C:\> Test-CATemplate -TemplateName WebServerCustom
```

Tests if the template WebServerCustom exists

## PARAMETERS

### -TemplateName
The name of the template

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
