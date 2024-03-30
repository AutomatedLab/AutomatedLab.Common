---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Receive-RunspaceJob

## SYNOPSIS
Receive the results of a runspace job

## SYNTAX

```
Receive-RunspaceJob [[-RunspaceJob] <Object[]>] [<CommonParameters>]
```

## DESCRIPTION
Receive the results of a runspace job

## EXAMPLES

### Example 1
```
PS C:\> $jobs | Receive-RunspaceJob
```

Receives the results of a bunch of runspace jobs

## PARAMETERS

### -RunspaceJob
The job objects

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object[]
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
