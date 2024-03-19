---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# ConvertTo-MaskLength

## SYNOPSIS
Converts an IP to a CIDR subnet length

## SYNTAX

```
ConvertTo-MaskLength [-SubnetMask] <IPAddress> [<CommonParameters>]
```

## DESCRIPTION
Converts an IP to a CIDR subnet length

## EXAMPLES

### Dotted IP to CIDR
```
PS C:\> ConvertTo-MaskLength 255.255.255.248
```

29

## PARAMETERS

### -SubnetMask
The ip address to convert

```yaml
Type: IPAddress
Parameter Sets: (All)
Aliases: Mask

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
