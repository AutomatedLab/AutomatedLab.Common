---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Install-SoftwarePackage

## SYNOPSIS

Install a software package

## SYNTAX

```
Install-SoftwarePackage [-Path] <String> [[-CommandLine] <String>] [[-AsScheduledJob] <Boolean>]
 [[-UseShellExecute] <Boolean>] [-ExpectedReturnCodes <Int32[]>] [[-Credential] <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION

Install a binary package, with the ability to define expected return codes or have the setup
run as a scheduled job

## EXAMPLES

### Example 1
```powershell
PS C:\> Install-SoftwarePackage -Path .\notepadplusplus.exe -CommandLine "/s"
```

Runs the installer for Notepad++ with the silent switch.

## PARAMETERS

### -Path
The package path

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommandLine
The command line arguments to use. Default for msi: /i /qn /L*v \<temporary log path\>
Default for msu: /Online /Add-Package /PackagePath:""$cabFile"" /NoRestart /Quiet
No defaults for exe

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsScheduledJob
Run installation in a scheduled job in case the installation in the current PowerShell process does not work.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseShellExecute
Set the property UseShellExecute for the ProcessStartInfo object

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
The credential to execute the installation with

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpectedReturnCodes
The list of expected return codes

```yaml
Type: Int32[]
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

## OUTPUTS

## NOTES

## RELATED LINKS
