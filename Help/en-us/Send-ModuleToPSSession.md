---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Send-ModuleToPSSession

## SYNOPSIS
Send an entire module to a remote session

## SYNTAX

```
Send-ModuleToPSSession [-Module] <PSModuleInfo> [-Session] <PSSession[]> [-Scope <String>]
 [-IncludeDependencies] [-Move] [-Encrypt] [-NoWriteBuffer] [-Verify] [-Force] [-NoClobber]
 [-MaxBufferSize <UInt32>] [<CommonParameters>]
```

## DESCRIPTION
Send an entire module to a remote session, including any dependencies and with the ability to encrypt or move.
The module needs to be defined by a manifest.

## EXAMPLES

### Example 1
```
PS C:\> Send-ModuleToPSSession -Module (Get-Module -List AutomatedLab.Common)[0] -Session (New-PSSession -ComputerName Host1,Host2,Host3) -IncludeDependencies
```

Copies the module AutomatedLab.Common to three PowerShell Sessions

## PARAMETERS

### -Encrypt
Indicates that EFS should be used

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

### -Force
Indicates that the module should always be transmitted regardless of the version that already exists on the remote

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

### -IncludeDependencies
Indicates that module dependencies should be copied as well

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

### -MaxBufferSize
@{Text=}

```yaml
Type: UInt32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Module
The module to send

```yaml
Type: PSModuleInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Move
INdicates that the module should be moved instead of copied

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

### -NoClobber
@{Text=}

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

### -NoWriteBuffer
@{Text=}

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

### -Scope
The scope, i.e.
CurrentUser or allUsers

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Session
The sessions to send the module to

```yaml
Type: PSSession[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Verify
@{Text=}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.IO.FileInfo
## NOTES

## RELATED LINKS
