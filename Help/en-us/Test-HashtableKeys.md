---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Test-HashtableKeys

## SYNOPSIS
Test the keys of a hashtable

## SYNTAX

```
Test-HashtableKeys [-Hashtable] <Hashtable> [[-MandatoryKeys] <String[]>] [[-ValidKeys] <String[]>] [-Quiet]
 [<CommonParameters>]
```

## DESCRIPTION
Test the keys of a hashtable for mandatory keys as well as invalid keys

## EXAMPLES

### Example 1
```
PS C:\> $bla = @{UserName = 'Hans'; Password = 'Swordfish'; HostName = 'Invalid'}
PS C:\> Test-Hashtable -Hashtable $bla -MandatoryKeys UserName, Password -ValidKeys UserName, Password, ComputerName
```

Writes an error since HostName is an invalid key

### Example 2
```
PS C:\> $bla = @{UserName = 'Hans'; Password = 'Swordfish'; HostName = 'Invalid'}
PS C:\> Test-Hashtable -Hashtable $bla -MandatoryKeys UserName, Password -ValidKeys UserName, Password, ComputerName -Quiet
```

Returns false and does not write an error

### Example 3
```
PS C:\> $bla = @{UserName = 'Hans';}
PS C:\> Test-Hashtable -Hashtable $bla -MandatoryKeys UserName, Password -ValidKeys UserName, Password, ComputerName
```

Writes an error since Password is required

## PARAMETERS

### -Hashtable
The hashtable to check

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MandatoryKeys
The list of mandatory keys

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quiet
Indicates that no exception should be recordded

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

### -ValidKeys
The list of valid keys

```yaml
Type: String[]
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

## OUTPUTS

## NOTES

## RELATED LINKS
