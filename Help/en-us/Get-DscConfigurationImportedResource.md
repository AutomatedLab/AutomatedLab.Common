---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-DscConfigurationImportedResource

## SYNOPSIS
Retrieve all imported resource modules from a DSC configuration

## SYNTAX

### ByFile
```
Get-DscConfigurationImportedResource -FilePath <String> [<CommonParameters>]
```

### ByConfiguration
```
Get-DscConfigurationImportedResource -Configuration <System.Management.Automation.ConfigurationInfo> [<CommonParameters>]
```

## DESCRIPTION
Retrieve all imported resource modules from a DSC configuration by examining the AST. Configurations
need to be stored in files to be examined.

## EXAMPLES

### Simple

```powershell
@'
configuration stuff
{
    Import-DscResource -ModuleName nx

    node localhost
    {
        nxFile f1
        {
            DestinationPath = '/var/opt/somefile.ini'
        }
    }
}
'@ | Set-Content .\ConfigurationFile.ps1
.\ConfigurationFile.ps1

Get-DscConfigurationImportedResource -Configuration (Get-Command -Name stuff)
```

Returns "nx"

## PARAMETERS

### -FilePath
The script file containing the DSC configuration

```yaml
Type: String
Parameter Sets: ByFile
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Configuration
A configuration that has already been imported an can be received using Get-Command

```yaml
Type: System.Management.Automation.ConfigurationInfo
Parameter Sets: ByConfiguration
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

## OUTPUTS

## NOTES

## RELATED LINKS
