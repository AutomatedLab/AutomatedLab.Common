---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# ConvertTo-Mask

## SYNOPSIS
Converts a CIDR mask length to the dotted IP address

## SYNTAX

```
ConvertTo-Mask [-MaskLength] <Object> [<CommonParameters>]
```

## DESCRIPTION
Converts a CIDR mask length to the dotted IP address

## EXAMPLES

### CIDR 28

```powershell
PS C:\> ConvertTo-Mask 28
```

255.255.255.240

## PARAMETERS

### -MaskLength
The prefix to convert

```yaml
Type: Object
Parameter Sets: (All)
Aliases: Length

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
