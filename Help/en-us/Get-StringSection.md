---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-StringSection

## SYNOPSIS
Split a string into an array in sections defined by the section size

## SYNTAX

```
Get-StringSection [-String] <String> [-SectionSize] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Split a string into an array in sections defined by the section size

## EXAMPLES

### Example 1
```
PS C:\> (Get-StringSection -String 00155DE63F36 -SectionSize 2) -join ':'
```

Returns a MAC address delimited by : from a string

## PARAMETERS

### -SectionSize
The amount of characters in each split

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -String
The string to split

```yaml
Type: String
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
