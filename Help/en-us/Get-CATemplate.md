---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-CATemplate

## SYNOPSIS

Find a CA template

## SYNTAX

```
Get-CATemplate [-TemplateName] <String> [<CommonParameters>]
```

## DESCRIPTION

Find a CA template

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-CATemplate -TemplateName WebServer
```

Attempts to find the template called WebServer

## PARAMETERS

### -TemplateName

The template name (not display name)

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
