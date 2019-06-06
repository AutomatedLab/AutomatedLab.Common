---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# ConvertTo-DottedDecimalIP

## SYNOPSIS
Converts decimal and binary IPs to their dotted form

## SYNTAX

```
ConvertTo-DottedDecimalIP [-IPAddress] <String> [<CommonParameters>]
```

## DESCRIPTION
Converts decimal and binary IPs to their dotted form

## EXAMPLES

### Binary

```powershell
PS C:\> ConvertTo-DottedDecimalIP -IPAddress 00000001.00000010.00000011.00000100
```

1.2.3.4

### Decimal

```powershell
PS C:\> ConvertTo-DottedDecimalIP -IPAddress 3232236133
```

192.168.2.101

## PARAMETERS

### -IPAddress
The binary or decimal to convert to a dotted IP

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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
