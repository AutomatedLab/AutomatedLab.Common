---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Add-FunctionToPSSession

## SYNOPSIS
Sends entire functions to remote sessions

## SYNTAX

```
Add-FunctionToPSSession [-Session] <PSSession[]> [-FunctionInfo] <FunctionInfo> [<CommonParameters>]
```

## DESCRIPTION
Sends the entire function definition to a remote session, so that scoping is not an issue any more

## EXAMPLES

### Send function

```powershell
PS C:\ $Session = New-PSSession myTargetMachine
PS C:\ Add-FunctionToPsSession $session -FunctionInfo (Get-Command Test-IsAdministrator)
```

Sends the function Test-IsAdministrator to the remote session $session

## PARAMETERS

### -Session
One or more remote sessions that will receive the functions

```yaml
Type: PSSession[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FunctionInfo
The FunctionInfo of the function to send, e.g.
(Get-Command Get-Type)

```yaml
Type: FunctionInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
