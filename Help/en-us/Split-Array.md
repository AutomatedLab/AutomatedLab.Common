---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Split-Array

## SYNOPSIS
Split one array into several collections

## SYNTAX

### ChunkSize
```
Split-Array -List <IEnumerable> -ChunkSize <Int32> [<CommonParameters>]
```

### ChunkCount
```
Split-Array -List <IEnumerable> -ChunkCount <Int32> [<CommonParameters>]
```

## DESCRIPTION
Split one array into several collections

## EXAMPLES

### Example 1
```powershell
PS C:\> Split-Array -List 1,2,3,4 -ChunkSize 2
```

Splits the list 1,2,3,4 in the two lists 1,2 and 3,4

## PARAMETERS

### -ChunkCount
The amount of separate lists to return

```yaml
Type: Int32
Parameter Sets: ChunkCount
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChunkSize
The size of each returned list

```yaml
Type: Int32
Parameter Sets: ChunkSize
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -List
The list to split

```yaml
Type: IEnumerable
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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
