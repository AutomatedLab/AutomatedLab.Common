---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-TfsBuildDefinition

## SYNOPSIS
Gets all build definitions for a project

## SYNTAX

### Cred (Default)
```
Get-TfsBuildDefinition -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 [-ApiVersion <String>] -ProjectName <String> [-QueueName <String>] [-UseSsl] -Credential <PSCredential>
 [<CommonParameters>]
```

### Pat
```
Get-TfsBuildDefinition -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 [-ApiVersion <String>] -ProjectName <String> [-QueueName <String>] [-UseSsl] -PersonalAccessToken <String>
 [<CommonParameters>]
```

## DESCRIPTION
Gets all build definitions for a project

## EXAMPLES

### List available build defs

```powershell
Get-TfsBuildDefinition -InstanceName 'dsc1tfs1' -CollectionName automatedlab -ProjectName somenewname -Credential $cred
```

_links        : @{self=; web=; editor=}
quality       : definition
defaultBranch : refs/heads/master
authoredBy    : @{id=41d58475-a24b-4ef0-bf36-dc7785ba9967; displayName=Install; uniqueName=DSC1TFS1\Install; url=http://dsc1tfs1:8080/tfs/AutomatedLab/_apis/Identities/41d58475-a24b-4ef0-bf36-dc7785ba9967;
                imageUrl=http://dsc1tfs1:8080/tfs/AutomatedLab/_api/_common/identityImage?id=41d58475-a24b-4ef0-bf36-dc7785ba9967}
queue         : @{pool=; id=1; name=Default}
uri           : vstfs:///Build/Definition/1
path          : \
type          : build
revision      : 2
createdDate   : 2018-03-14T08:50:06.297Z
id            : 1
name          : myDefinition
url           : http://dsc1tfs1:8080/tfs/AutomatedLab/1900e200-5238-4956-816c-b29c50163f93/_apis/build/Definitions/1
project       : @{id=1900e200-5238-4956-816c-b29c50163f93; name=someNewName; description=SomeNewText; url=http://dsc1tfs1:8080/tfs/AutomatedLab/_apis/projects/1900e200-5238-4956-816c-b29c50163f93;
                state=wellFormed; revision=29}

_links        : @{self=; web=; editor=}
quality       : definition
defaultBranch : refs/heads/master
authoredBy    : @{id=41d58475-a24b-4ef0-bf36-dc7785ba9967; displayName=Install; uniqueName=DSC1TFS1\Install; url=http://dsc1tfs1:8080/tfs/AutomatedLab/_apis/Identities/41d58475-a24b-4ef0-bf36-dc7785ba9967;
                imageUrl=http://dsc1tfs1:8080/tfs/AutomatedLab/_api/_common/identityImage?id=41d58475-a24b-4ef0-bf36-dc7785ba9967}
queue         : @{pool=; id=5; name=SuperQueue}
uri           : vstfs:///Build/Definition/2
path          : \
type          : build
revision      : 1
createdDate   : 2018-03-15T10:15:10.677Z
id            : 2
name          : myDefinition2
url           : http://dsc1tfs1:8080/tfs/AutomatedLab/1900e200-5238-4956-816c-b29c50163f93/_apis/build/Definitions/2
project       : @{id=1900e200-5238-4956-816c-b29c50163f93; name=someNewName; description=SomeNewText; url=http://dsc1tfs1:8080/tfs/AutomatedLab/_apis/projects/1900e200-5238-4956-816c-b29c50163f93;
                state=wellFormed; revision=29}

_links        : @{self=; web=; editor=}
quality       : definition
defaultBranch : refs/heads/master
authoredBy    : @{id=41d58475-a24b-4ef0-bf36-dc7785ba9967; displayName=Install; uniqueName=DSC1TFS1\Install; url=http://dsc1tfs1:8080/tfs/AutomatedLab/_apis/Identities/41d58475-a24b-4ef0-bf36-dc7785ba9967;
                imageUrl=http://dsc1tfs1:8080/tfs/AutomatedLab/_api/_common/identityImage?id=41d58475-a24b-4ef0-bf36-dc7785ba9967}
queue         : @{pool=; id=5; name=SuperQueue}
uri           : vstfs:///Build/Definition/3
path          : \
type          : build
revision      : 1
createdDate   : 2018-03-15T10:16:44.287Z
id            : 3
name          : myDefinition3
url           : http://dsc1tfs1:8080/tfs/AutomatedLab/1900e200-5238-4956-816c-b29c50163f93/_apis/build/Definitions/3
project       : @{id=1900e200-5238-4956-816c-b29c50163f93; name=someNewName; description=SomeNewText; url=http://dsc1tfs1:8080/tfs/AutomatedLab/_apis/projects/1900e200-5238-4956-816c-b29c50163f93;
                state=wellFormed; revision=29}

_links        : @{self=; web=; editor=}
quality       : definition
defaultBranch : refs/heads/master
authoredBy    : @{id=41d58475-a24b-4ef0-bf36-dc7785ba9967; displayName=Install; uniqueName=DSC1TFS1\Install; url=http://dsc1tfs1:8080/tfs/AutomatedLab/_apis/Identities/41d58475-a24b-4ef0-bf36-dc7785ba9967;
                imageUrl=http://dsc1tfs1:8080/tfs/AutomatedLab/_api/_common/identityImage?id=41d58475-a24b-4ef0-bf36-dc7785ba9967}
queue         : @{pool=; id=1; name=Default}
uri           : vstfs:///Build/Definition/4
path          : \
type          : build
revision      : 1
createdDate   : 2018-03-15T10:36:49.54Z
id            : 4
name          : ALBuild
url           : http://dsc1tfs1:8080/tfs/AutomatedLab/1900e200-5238-4956-816c-b29c50163f93/_apis/build/Definitions/4
project       : @{id=1900e200-5238-4956-816c-b29c50163f93; name=someNewName; description=SomeNewText; url=http://dsc1tfs1:8080/tfs/AutomatedLab/_apis/projects/1900e200-5238-4956-816c-b29c50163f93;
                state=wellFormed; revision=29}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
