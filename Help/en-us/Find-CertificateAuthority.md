---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Find-CertificateAuthority

## SYNOPSIS
Discover a certificate authority

## SYNTAX

```
Find-CertificateAuthority [[-DomainName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Discover a certificate authority that is registered in Active Directory

## EXAMPLES

### Example 1
```
PS C:\> Find-CertificateAuthority -DomainName contoso.com
```

Discovers the certificate authorities for contoso.com

## PARAMETERS

### -DomainName
The domain to look in

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

## OUTPUTS

## NOTES

## RELATED LINKS
