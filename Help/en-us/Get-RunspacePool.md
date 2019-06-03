---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-RunspacePool

## SYNOPSIS
Get all active runspace pools

## SYNTAX

```
Get-RunspacePool [[-ThrottleLimit] <Int32>] [[-ApartmentState] <ApartmentState>] [<CommonParameters>]
```

## DESCRIPTION
Get all active runspace pools that match the selected parameters like ThrottleLimit and ApartmentState

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-RunspacePool
```

Returns all runspace pools

### Example 2
```powershell
PS C:\> Get-RunspacePool -ThrottleLimit 10 -ApartmentState MTA
```

Gets all runspace pools with a throttle limit of 10

## PARAMETERS

### -ApartmentState

The thread apartment state (not on PS Core), e.g. STA, MTA or Unknown

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

The throttle limit of the runspace pool

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Management.Automation.Runspaces.RunspacePool[]

## NOTES

## RELATED LINKS
