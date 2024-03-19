---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Start-RunspaceJob

## SYNOPSIS
Start a new job in a runspace pool

## SYNTAX

```
Start-RunspaceJob [-ScriptBlock] <ScriptBlock> [-RunspacePool] <RunspacePool> [[-Argument] <Object[]>]
 [<CommonParameters>]
```

## DESCRIPTION
Start a new script block inside of a runspace pool.
The pool controls the parallelization going on.
You can optionally pass arguments.

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

### -Argument
Arguments to pass to the script block

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunspacePool
The runspace pool to use

```yaml
Type: RunspacePool
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock
The script block to run

```yaml
Type: ScriptBlock
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

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
