---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Request-Certificate

## SYNOPSIS

Request a new certificate from a certificate authority

## SYNTAX

```
Request-Certificate [-Subject] <String> [[-SAN] <String[]>] [[-OnlineCA] <String>] [-TemplateName] <String>
 [<CommonParameters>]
```

## DESCRIPTION

Request a new certificate from a certificate authority. Supports multiple Subject Alternative Names

## EXAMPLES

### Example 1
```powershell
PS C:\> Request-Certificate -Subject 'CN=nyanhp' -SAN 'CN=ElBarto' -OnlineCA (Find-CertificateAuthority -Domain contoso.com) -TemplateName DocEncryption
```

Attempts to request a certificate using the DocEncryption certificate template and an auto-discovered CA.

## PARAMETERS

### -Subject
The subject name

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

### -SAN
A list of subject alternative names

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnlineCA
The CA to query

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateName
The template to enroll in

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
