---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# ConvertTo-BinaryIP

## SYNOPSIS
Converts a given IPv4 to binary

## SYNTAX

```
ConvertTo-BinaryIP [-IPAddress] <IPAddress> [<CommonParameters>]
```

## DESCRIPTION
Converts a given IPv4 address to its binary representation as string

## EXAMPLES

### Convert an IP

```powershell
PS C:\> ConvertTo-BinaryIp 192.168.2.101
```

Returns the string 11000000.10101000.00000010.01100101

## PARAMETERS

### -IPAddress
The IPv4 address to convert to binary

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
