---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-DotNetFrameworkVersion

## SYNOPSIS

Get the .NET framework version info from Windows Registry

## SYNTAX

```
Get-DotNetFrameworkVersion [[-ComputerName] <String>]
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

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
