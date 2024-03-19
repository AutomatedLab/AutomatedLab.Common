---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-FullMesh

## SYNOPSIS
Gets a uni- or bi-directional mesh for a given list of values

## SYNTAX

```
Get-FullMesh [-List] <Array> [-OneWay] [<CommonParameters>]
```

## DESCRIPTION
Gets a uni- or bi-directional mesh for a given list of values

## EXAMPLES

### Domain trust
```
PS C:\> Get-FullMesh -List @('contoso.com','fabrikam.com','tailspintoys.com')
```

Source           Destination ------           ----------- contoso.com      fabrikam.com contoso.com      tailspintoys.com fabrikam.com     contoso.com fabrikam.com     tailspintoys.com tailspintoys.com contoso.com tailspintoys.com fabrikam.com

### One-way
```
PS C:\> Get-FullMesh -List @('contoso.com','fabrikam.com','tailspintoys.com') -OneWay
```

Source       Destination ------       ----------- contoso.com  fabrikam.com contoso.com  tailspintoys.com fabrikam.com tailspintoys.com

## PARAMETERS

### -List
The input list

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OneWay
Enables uni-directional mesh

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
