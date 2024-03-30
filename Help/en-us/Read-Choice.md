---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Read-Choice

## SYNOPSIS
Read a user's choice from the command line

## SYNTAX

```
Read-Choice [-ChoiceList] <String[]> [-Caption] <String> [[-Message] <String>] [[-Default] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Read a user's choice from the command line

## EXAMPLES

### Example 1
```
PS C:\> Read-Choice "&Apples","&Oranges" -Caption "Please select" -Message "What are we comparing today?"
```

Prompts the user to choose between Apples and Oranges.
Using the Ampersand, one character can be used to make the selection easier

## PARAMETERS

### -Caption
The caption of the request

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
The list of possible options.
Include a & in each option to specify which key can be pressed for the option

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

### -Default
The default element from ChoiceList

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
