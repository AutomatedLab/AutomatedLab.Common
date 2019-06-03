---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-NextOid

## SYNOPSIS

Get a new valid Object Identifier (OID)

## SYNTAX

```
Get-NextOid [-Oid] <String> [<CommonParameters>]
```

## DESCRIPTION

Get a new valid Object Identifier (OID), for example to be used when creating a new CA template with the New-CATemplate cmdlet.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-NextOid -Oid 1.3.6.1.4.1.311.42.1.17
```

Returns 1.3.6.1.4.1.311.42.1.18

## PARAMETERS

### -Oid
The OID to increment

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
