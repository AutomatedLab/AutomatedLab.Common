---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Split-Array

## SYNOPSIS
Split one array into several collections

## SYNTAX

### MaxChunkSize
```
Split-Array -List <IEnumerable> -MaxChunkSize <Int32> [-AllowEmptyChunks] [<CommonParameters>]
```

### ChunkCount
```
Split-Array -List <IEnumerable> -ChunkCount <Int32> [-AllowEmptyChunks] [<CommonParameters>]
```

## DESCRIPTION
Split one array into several collections

## EXAMPLES

### Example 1
```
PS C:\> Split-Array -List 1,2,3,4 -ChunkSize 2
```

Splits the list 1,2,3,4 in the two lists 1,2 and 3,4

## PARAMETERS

### -AllowEmptyChunks
{{ Fill AllowEmptyChunks Description }}

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

### -MaxChunkSize
{{ Fill MaxChunkSize Description }}

```yaml
Type: Int32
Parameter Sets: MaxChunkSize
Aliases: ChunkSize

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
