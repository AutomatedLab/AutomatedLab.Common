---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-TfsAgentQueue

## SYNOPSIS
Get the agent queue of a project

## SYNTAX

### Cred
```
Get-TfsAgentQueue -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -ProjectName <String> [-QueueName <String>] [-UseSsl] -Credential <PSCredential> [-SkipCertificateCheck]
 [<CommonParameters>]
```

### Pat
```
Get-TfsAgentQueue -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -ProjectName <String> [-QueueName <String>] [-UseSsl] -PersonalAccessToken <String> [-SkipCertificateCheck]
 [<CommonParameters>]
```

## DESCRIPTION
Get the agent queue of a project

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-TfsAgentQueue -InstanceName 'dsc1tfs1' -CollectionName AutomatedLab -ProjectName someNewname -Credential (Get-Credential)
```

id           : 1
projectId    : 1900e200-5238-4956-816c-b29c50163f93
name         : Default
groupScopeId : 48bc4217-c583-42b0-b668-c0faf33c0f72
pool         : @{id=1; scope=6102e06e-0add-4f5b-8e22-0efda7ef0920; name=Default}

id           : 5
projectId    : 1900e200-5238-4956-816c-b29c50163f93
name         : SuperQueue
groupScopeId : 40ea4404-6a69-45a8-a544-5045ae64ca20
pool         : @{id=2; scope=6102e06e-0add-4f5b-8e22-0efda7ef0920; name=SuperQueue}

id           : 6
projectId    : 1900e200-5238-4956-816c-b29c50163f93
name         : AwesomeQueue
groupScopeId : 5aa4d198-b85e-4dae-9963-59c3f8ced07b
pool         : @{id=1; scope=6102e06e-0add-4f5b-8e22-0efda7ef0920; name=Default}

## PARAMETERS

### -InstanceName
The instance name (dev.azure.com/username or your TFS host name)

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

### -CollectionName
Your collection.
Defaults to DefaultCollection

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

### -Port
The port of your installation/VSTS instance

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

### -ProjectName
The name of your team project

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

### -QueueName
The name of your project's agent queue

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
The TFS credential to use

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

### -PersonalAccessToken
The VSTS access token as returned by Get-TfsAccessTokenString

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

### -UseSsl
Indicates that SSL should be used

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

## OUTPUTS

## NOTES

## RELATED LINKS
