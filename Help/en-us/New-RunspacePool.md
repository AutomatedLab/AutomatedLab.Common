---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# New-RunspacePool

## SYNOPSIS
Create a new runspace pool

## SYNTAX

```
New-RunspacePool [[-ThrottleLimit] <Int32>] [[-ApartmentState] <ApartmentState>] [[-Variable] <PSVariable[]>]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new runspace pool with the specified throttle limit, apartment state and variables

## EXAMPLES

### Example 1
```powershell
PS C:\> New-RunspacePool -ThrottleLimit 10 -Variable (Get-Variable Credential, Path)
```

Creates a runspace pool with a maximum of 10 runspaces and transfers the variable Credential and Path to it.

## PARAMETERS

### -ApartmentState
The thread apartment state, e.g STA (single-threaded) or MTA (multi-threaded)

```yaml
Type: ApartmentState
Parameter Sets: (All)
Aliases:
Accepted values: STA, MTA, Unknown

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit
The throttle limit

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Variable
A list of variables transferred into each runspace pool. Shared by the entire pool

```yaml
Type: PSVariable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Management.Automation.Runspaces.RunspacePool

## NOTES

## RELATED LINKS
