---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-TfsAgentPool

## SYNOPSIS
Gets the TFS/VSTS agent pool

## SYNTAX

### Cred
```
Get-TfsAgentPool -InstanceName <String> [-CollectionName <String>] [-PoolName <String>] [-Port <UInt32>]
 [-ApiVersion <String>] [-UseSsl] -Credential <PSCredential> [-SkipCertificateCheck] [<CommonParameters>]
```

### Pat
```
Get-TfsAgentPool -InstanceName <String> [-CollectionName <String>] [-PoolName <String>] [-Port <UInt32>]
 [-ApiVersion <String>] [-UseSsl] -PersonalAccessToken <String> [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Gets the agent pool for a TFS/VSTS instance

## EXAMPLES

### Example 1

```powershell
Get-TfsAgentPool -InstanceName 'dsc1tfs1' -Credential (Get-Credential)
```

Returns the agent pools

size          : 0
createdOn     : 2018-03-06T20:26:31.593Z
autoProvision : True
isHosted      : False
createdBy     : @{id=0205dc57-d053-404d-8f34-0d6f03c32b08; displayName=\[TEAM FOUNDATION\]\Team Foundation Service Accounts; uniqueName=vstfs:///Framework/IdentityDomain/6102e06e-0add-4f5b-8e22-0efda7ef0920\Team
                Foundation Service Accounts; isContainer=True}
groupScopeId  : f278594b-ade1-424f-a9f3-8eef10e1efdf
id            : 1
scope         : 6102e06e-0add-4f5b-8e22-0efda7ef0920
name          : Default

size          : 3
createdOn     : 2018-03-13T13:22:57.83Z
autoProvision : False
isHosted      : False
createdBy     : @{id=f72e1714-cec1-498a-a4f7-12a14f12e491; displayName=Install; uniqueName=DSC1TFS1\Install}
groupScopeId  : e2906f7b-9180-48e7-9d3d-4230c3c4804a
id            : 2
scope         : 6102e06e-0add-4f5b-8e22-0efda7ef0920
name          : SuperQueue

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

### -CollectionName
The collection name

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

### -PoolName
The agent pool

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
