---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-TfsAccessTokenString

## SYNOPSIS
Gets the VSTS PAT base64 encoded

## SYNTAX

```
Get-TfsAccessTokenString [-PersonalAccessToken] <String> [<CommonParameters>]
```

## DESCRIPTION
Gets the VSTS PAT base64 encoded to use with the TFS cmdlets

## EXAMPLES

### Example 1

```powershell
Get-TfsAccessTokenString -PersonalAccessToken (New-Guid).Guid
```

Returns a string along the lines of "Basic OjU1YjE0Mzc4LWIxZGYtNDY3Ny1iMzEyLTM5NDAzODE4ZjZjNQ=="

## PARAMETERS

### -PersonalAccessToken
Your VSTS personal access token (see https://dev.azure.com/\[YOUR USERNAME\]/_details/security/tokens for details.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES

## RELATED LINKS
