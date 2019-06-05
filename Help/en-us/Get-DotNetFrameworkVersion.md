---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-DotNetFrameworkVersion

## SYNOPSIS

Get the .NET framework version info from Windows Registry

## SYNTAX

```
Get-DotNetFrameworkVersion [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION

Get the .NET framework version info from Windows Registry locally or remotely. If remote computers
are targeted, RPC/DCOM must be allowed.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-DotNetFrameworkVersion
```

PS C:\> get-dotnetframeworkversion

ComputerName  Build Version        Comment
------------  ----- -------        -------
BORBARAD      50727 2.0.50727.4927        
BORBARAD      30729 3.0.30729.4926        
BORBARAD      30729 3.5.30729.4926        
BORBARAD     528040

## PARAMETERS

### -ComputerName

Optional, one or more machines to test

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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
