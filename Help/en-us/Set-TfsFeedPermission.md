---
external help file: AutomatedLab.Common-help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Set-TfsFeedPermission

## SYNOPSIS
Sets the feed's permissions

## SYNTAX

### Tfs
```
Set-TfsFeedPermission -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -FeedName <String> -Permissions <Object[]> [-UseSsl] [-Credential <PSCredential>] [-SkipCertificateCheck]
 [<CommonParameters>]
```

### Vsts
```
Set-TfsFeedPermission -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>] [-ApiVersion <String>]
 -FeedName <String> -Permissions <Object[]> [-UseSsl] [-PersonalAccessToken <String>] [-SkipCertificateCheck]
 [<CommonParameters>]
```

## DESCRIPTION
Sets the feed's permissions

## EXAMPLES

### Example 1
```powershell
$p = @()
$p += (New-Object pscustomobject -Property @{ role = 'administrator'; identityDescriptor = 'System.Security.Principal.WindowsIdentity;S-1-5-21-3840877469-1399940413-2468247932-1000' })
$p += (New-Object pscustomobject -Property @{ role = 'administrator'; identityDescriptor = 'Microsoft.TeamFoundation.Identity;S-1-9-1551374245-688677674-3599067981-2526903658-827877225-0-0-0-0-1' })
$p += (New-Object pscustomobject -Property @{ role = 'administrator'; identityDescriptor = 'Microsoft.TeamFoundation.Identity;S-1-9-1551374245-3941645230-359989830-2867240742-1249722431-0-0-0-0-1' })
$p += (New-Object pscustomobject -Property @{ role = 'reader'; identityDescriptor = 'System.Security.Principal.WindowsIdentity;S-1-5-21-3840877469-1399940413-2468247932-513' })

New-TfsFeed @defaultParam -FeedName New2
Set-TfsFeedPermissions @defaultParam -FeedName New2 -Permissions $p
```

Creates a new feed and assignes permissions. Makre sure the SIDs are taken from the domain the TFS / Azure DevOps server is a member of.

## PARAMETERS

### -ApiVersion
{{ Fill ApiVersion Description }}

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
{{ Fill CollectionName Description }}

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
{{ Fill Credential Description }}

```yaml
Type: PSCredential
Parameter Sets: Tfs
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FeedName
{{ Fill FeedName Description }}

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

### -InstanceName
{{ Fill InstanceName Description }}

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

### -Permissions
{{ Fill Permissions Description }}

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersonalAccessToken
{{ Fill PersonalAccessToken Description }}

```yaml
Type: String
Parameter Sets: Vsts
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
{{ Fill Port Description }}

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

### -SkipCertificateCheck
{{ Fill SkipCertificateCheck Description }}

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

### -UseSsl
{{ Fill UseSsl Description }}

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
