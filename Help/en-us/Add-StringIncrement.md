---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Add-StringIncrement

## SYNOPSIS
Increments a string

## SYNTAX

```
Add-StringIncrement [-String] <String> [<CommonParameters>]
```

## DESCRIPTION
Increments a given string "\<some text\> \<int\>" by one.

## EXAMPLES

### Connections
```
PS C:\> Add-StringIncrement -String "Local Area Connection 1"
```

Returns "Local Area Connection 2"

## PARAMETERS

### -String
The string to increment

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
