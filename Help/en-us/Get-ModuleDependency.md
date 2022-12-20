---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-ModuleDependency

## SYNOPSIS

Retrieve dependencies of a module recursively as file system paths or module data types

## SYNTAX

```
Get-ModuleDependency [-Module] <PSModuleInfo> [-AsModuleInfo] [<CommonParameters>]
```

## DESCRIPTION

Retrieve dependencies of a module recursively as file system paths or module data types

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ModuleDependency -Module (Get-Module AutomatedLab.Common)
```

Returns a list of module dependencies' file system paths
C:\Program Files\WindowsPowerShell\Modules\newtonsoft.json\1.0.2.201
C:\Program Files\WindowsPowerShell\Modules\PSFileTransfer\5.46.1271
C:\Program Files\WindowsPowerShell\Modules\AutomatedLab.Common\2.2.247

## PARAMETERS

### -Module
The module to analyze

```yaml
Type: PSModuleInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsModuleInfo

Indicates that module data type instead of ModuleBase property should be returned

```yaml
Type: SwitchParameter
Parameter Sets: (All)
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
