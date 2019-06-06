---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-BroadcastAddress

## SYNOPSIS

Get the broadcast address of a network

## SYNTAX

```
Get-BroadcastAddress [-IPAddress] <IPAddress> [-SubnetMask] <IPAddress> [<CommonParameters>]
```

## DESCRIPTION

Get the broadcast address of a network

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-BroadcastAddress -IPAddress 192.168.2.123 -SubnetMask 255.255.255.0
```

Returns the broadcast address 192.168.2.255

## PARAMETERS

### -IPAddress

The IP Address

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

### -SubnetMask

The subnet mask

```yaml
Type: IPAddress
Parameter Sets: (All)
Aliases: Mask

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
