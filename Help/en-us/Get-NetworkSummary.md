---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-NetworkSummary

## SYNOPSIS
Get a custom object with detailed information about a network

## SYNTAX

```
Get-NetworkSummary [-IPAddress] <String> [-SubnetMask] <String> [<CommonParameters>]
```

## DESCRIPTION
Get a custom object with detailed information about a network

## EXAMPLES

### Simple
```
PS C:\> Get-Networksummary -IPAddress 192.168.23.44 -SubnetMask 255.255.255.248
```

Network    : 192.168.23.40 Broadcast  : 192.168.23.47 Range      : 192.168.23.41 - 192.168.23.46 Mask       : 255.255.255.248 MaskLength : 29 Hosts      : 6 Class      : C IsPrivate  : True

## PARAMETERS

### -IPAddress
An IP address of the target network

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

### -SubnetMask
The subnet mask of the target network

```yaml
Type: String
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
