---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Read-HashTable

## SYNOPSIS
Reads input for items

## SYNTAX

```
Read-HashTable [-ChoiceList] <String[]> [-Caption] <String> [[-Message] <String>] [<CommonParameters>]
```

## DESCRIPTION
Reads input for hashtable keys specified by a choice list.

## EXAMPLES

### Example 1
```
PS C:\> Read-HashTable -ChoiceList PathToInstaller, InstallerArguments -Message "Provide the following values"
```

Reads the values to use for PathToInstaller and InstallerArguments and returns a hashtable

## PARAMETERS

### -Caption
The caption to display

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChoiceList
The list of hashtables keys to fill

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
The message to display

```yaml
Type: String
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
