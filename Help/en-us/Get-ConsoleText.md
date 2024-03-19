---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-ConsoleText

## SYNOPSIS
Get the current console text buffer

## SYNTAX

```
Get-ConsoleText [<CommonParameters>]
```

## DESCRIPTION
Get the current console text buffer for the ISE as well as the ConsoleHost

## EXAMPLES

### Example 1
```
PS C:\> Get-ConsoleText
```

Returns the console text

### Example 2
```
PS C:\> Get-ConsoleText | Set-Clipboard
```

Copies the console text to the clipboard

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
