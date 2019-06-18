---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# New-TfsReleaseDefinition

## SYNOPSIS
Create a new release definition

## SYNTAX

### Cred (Default)
```
New-TfsReleaseDefinition -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 [-ApiVersion <String>] -ProjectName <String> -ReleaseName <String> [-ReleaseTasks <Hashtable[]>]
 [-Environments <Hashtable[]>] [-UseSsl] -Credential <PSCredential> [-SkipCertificateCheck]
 [<CommonParameters>]
```

### Pat
```
New-TfsReleaseDefinition -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 [-ApiVersion <String>] -ProjectName <String> -ReleaseName <String> [-ReleaseTasks <Hashtable[]>]
 [-Environments <Hashtable[]>] [-UseSsl] -PersonalAccessToken <String> [-SkipCertificateCheck]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new release definition

## EXAMPLES

### Example 1
```powershell
$buildSteps = @(
    @{
        "enabled"         = $true
        "continueOnError" = $false
        "alwaysRun"       = $false
        "displayName"     = "Execute Build.ps1"
        "task"            = @{
            "id"          = "e213ff0f-5d5c-4791-802d-52ea3e7be1f1" # We need to refer to a valid ID - refer to Get-LabBuildStep for all available steps
            "versionSpec" = "*"
        }
        "inputs"          = @{
            scriptType          = "filePath"
            scriptName          = ".Build.ps1"
            arguments           = "-resolveDependency -IsRelease"
            failOnStandardError = $false
        }
    }
)

New-TfsProject -InstanceName DSCTFS -Port 443 -CollectionName 'AutomatedLab' -ProjectName 'DSC' -Credential $credential -UseSsl -SourceControlType Git -TemplateName 'Agile'
New-TfsReleaseDefinition -InstanceName DSCTFS -Port 443 -CollectionName 'AutomatedLab' -ProjectName 'DSC' -Credential $credential -DefinitionName ALBuild -BuildTasks $buildSteps -UseSsl
```

This extensive example shows you how to create a new code project and add a release definition that consists of a large hashtable.

## PARAMETERS

### -ApiVersion
The API version to use.
Refer to https://www.visualstudio.com/en-us/docs/integrate/api/overview for details

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

### -CollectionName
Your collection

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

### -Credential
The credential to use

```yaml
Type: PSCredential
Parameter Sets: Cred
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Environments
{{ Fill Environments Description }}

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceName
The instance name

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

### -PersonalAccessToken
Your personal access token

```yaml
Type: String
Parameter Sets: Pat
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
The TFS port

```yaml
Type: UInt32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProjectName
Your project name

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

### -ReleaseName
The name of the release pipeline

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

### -ReleaseTasks
The list of release tasks

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSsl
Indicates if SSL should be used

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

### -SkipCertificateCheck
Skip certificate validation

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
