---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# New-PerformanceDataCollectorSet

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### Counter (Default)
```
New-PerformanceDataCollectorSet -CollectorSetName <String> [-StartDate <DateTime>] [-ComputerName <String>]
 [<CommonParameters>]
```

### Counters
```
New-PerformanceDataCollectorSet -CollectorSetName <String> [-StartDate <DateTime>] [-Counters <String[]>]
 [-ComputerName <String>] [<CommonParameters>]
```

### Xml
```
New-PerformanceDataCollectorSet -CollectorSetName <String> [-StartDate <DateTime>]
 [-XmlTemplatePath <String[]>] [-ComputerName <String>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -CollectorSetName
{{ Fill CollectorSetName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
{{ Fill ComputerName Description }}

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

### -Counters
{{ Fill Counters Description }}

```yaml
Type: String[]
Parameter Sets: Counters
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
{{ Fill StartDate Description }}

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -XmlTemplatePath
{{ Fill XmlTemplatePath Description }}

```yaml
Type: String[]
Parameter Sets: Xml
Aliases:

Required: False
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
