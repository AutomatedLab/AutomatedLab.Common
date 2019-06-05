---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-NetworkRange

## SYNOPSIS
Get the usable range of addresses for a network

## SYNTAX

```
Get-NetworkRange [[-IPAddress] <String>] [[-SubnetMask] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get the usable range of addresses for a network

## EXAMPLES

### Small net

```powershell
PS C:\> Get-NetworkRange -IPAddress 192.168.23.44 -SubnetMask 255.255.255.248
```

192.168.23.41
192.168.23.42
192.168.23.43
192.168.23.44
192.168.23.45
192.168.23.46

## PARAMETERS

### -IPAddress
One IP address of the target network

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

Required: False
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
