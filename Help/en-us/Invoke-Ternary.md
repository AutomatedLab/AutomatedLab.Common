---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Invoke-Ternary

## SYNOPSIS
Replicate the ternary operator ?
in PowerShell

## SYNTAX

```
Invoke-Ternary [[-decider] <ScriptBlock>] [[-ifTrue] <ScriptBlock>] [[-ifFalse] <ScriptBlock>]
```

## DESCRIPTION
Replicate the ternary operator ?
in PowerShell

## EXAMPLES

### Example 1
```
PS C:\> Invoke-Ternary -Decider {(Get-Date).DayOfWeek -in 'Saturday', 'Sunday'} -IfTrue { 'Relax' } -IfFalse { 'Get to work' }
```

On a weekend, executes the script block for IfTrue, else it executes IfFalse

## PARAMETERS

### -decider
The script block that is evaluated

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ifFalse
The script block that is executed when the decider returns false

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ifTrue
The script block that is executed when the decider returns true

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
