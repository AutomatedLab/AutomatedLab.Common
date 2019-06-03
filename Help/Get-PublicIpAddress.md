---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-PublicIpAddress

## SYNOPSIS
Attempts to retrieve a public IP address

## SYNTAX

```
Get-PublicIpAddress [<CommonParameters>]
```

## DESCRIPTION
Attempts to retrieve a public IP address by trying 'https://api.ipify.org?format=json', 'https://ip.seeip.org/jsonip?', 'https://api.myip.com'

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PublicIpAddress
```

1.2.3.4

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
