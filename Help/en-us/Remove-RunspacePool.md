---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Remove-RunspacePool

## SYNOPSIS
Remove a runspace pool

## SYNTAX

```
Remove-RunspacePool [[-RunspacePool] <RunspacePool[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove a runspace pool

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-RunspacePool | Where RunspacePoolAvailability -eq 'None' | Remove-RunspacePool
```

Removes the runspace pools that have been found to be inaccessible.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunspacePool
One or more runspace pools to remove

```yaml
Type: RunspacePool[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Runspaces.RunspacePool[]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
