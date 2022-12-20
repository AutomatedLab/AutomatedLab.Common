---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-RequiredModulesFromMOF

## SYNOPSIS

Analyze MOF file to extract required DSC resource modules

## SYNTAX

```
Get-RequiredModulesFromMOF [-Path] <String> [<CommonParameters>]
```

## DESCRIPTION

Analyze MOF file to extract required DSC resource modules

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-RequiredModulesFromMOF C:\tmp\ThatMof.mof
```

Analyzes ThatMof.mof and returns a list of required modules

## PARAMETERS

### -Path
MOF file path

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
