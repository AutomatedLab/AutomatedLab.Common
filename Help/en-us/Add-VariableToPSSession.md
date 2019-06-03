---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Add-VariableToPSSession

## SYNOPSIS
Send a variable to a remote session

## SYNTAX

```
Add-VariableToPSSession [-Session] <PSSession[]> [-PSVariable] <PSVariable> [<CommonParameters>]
```

## DESCRIPTION
Sends an entire variable definition to one or more remote sessions, so that the using-scope is not necessary any longer

## EXAMPLES

### Send variable

```powershell
PS C:\> $Session = New-PSSession myTargetHost
PS C:\> Add-VariableToPsSession -Session $Session -Variable (Get-Variable myVar)
```

Sends $myVar to the session $session

## PARAMETERS

### -Session
One or more sessions to send the variables to

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

### -PSVariable
The variable to send to the session

```yaml
Type: PSVariable
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
