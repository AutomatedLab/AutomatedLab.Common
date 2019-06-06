---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-NetworkAddress

## SYNOPSIS
Calculate network address from given IP and net mask

## SYNTAX

```
Get-NetworkAddress [-IPAddress] <IPAddress> [-SubnetMask] <IPAddress> [<CommonParameters>]
```

## DESCRIPTION
Calculate network address from given IP and net mask

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-NetworkAddress -IPAddress 192.168.23.44 -SubnetMask 255.255.252.0
```

192.168.20.0

## PARAMETERS

### -IPAddress
An IP from the target network

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
The subnet mask of the target network

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
