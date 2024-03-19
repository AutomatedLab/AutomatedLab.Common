---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# ConvertTo-DecimalIP

## SYNOPSIS
Converts a given IPv4 to decimal

## SYNTAX

```
ConvertTo-DecimalIP [-IPAddress] <IPAddress> [<CommonParameters>]
```

## DESCRIPTION
Converts a given IPv4 to decimal

## EXAMPLES

### Convert an IP
```
PS C:\> ConvertTo-DecimalIP -IPAddress 192.168.2.101
```

Returns 3232236133

## PARAMETERS

### -IPAddress
The IPv4 address to convert

```yaml
Type: IPAddress
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
