---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Wait-RunspaceJob

## SYNOPSIS
Wait for runspace jobs to finish

## SYNTAX

```
Wait-RunspaceJob [[-RunspaceJob] <Object[]>] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
Wait for runspace jobs to finish

## EXAMPLES

### Example 1
```
PS C:\> $pool = New-RunspacePool -Throttle 10
PS C:\> $jobs = 1..100 | % { Start-RunspaceJob -RunspacePool $pool -ScriptBlock {Start-Sleep -Seconds 10; 'works'}}
PS C:\> $jobs | Wait-RunspaceJob
```

Enqueues 100 new jobs in a runspace pool that executes 10 jobs in parallel.
Will finish after approximately 10 seconds.

## PARAMETERS

### -PassThru
Return the jobs after waiting for them

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

### -RunspaceJob
The list of jobs to wait for

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
