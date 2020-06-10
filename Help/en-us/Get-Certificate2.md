---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-Certificate2

## SYNOPSIS

Get one or more certificates

## SYNTAX

### FindCer (Default)
```
Get-Certificate2 -SearchString <String> -FindType <X509FindType> [-Location <CertStoreLocation>]
 [-Store <string>] [-ServiceName <String>] [<CommonParameters>]
```

### FindPfx
```
Get-Certificate2 -SearchString <String> -FindType <X509FindType> [-Location <CertStoreLocation>]
 [-Store <string>] [-ServiceName <String>] -Password <SecureString> [-ExportPrivateKey] [<CommonParameters>]
```

### AllPfx
```
Get-Certificate2 [-Location <CertStoreLocation>] [-Store <string>] [-ServiceName <String>] [-All]
 [-IncludeServices] -Password <SecureString> [-ExportPrivateKey] [<CommonParameters>]
```

### AllCer
```
Get-Certificate2 [-Location <CertStoreLocation>] [-Store <string>] [-ServiceName <String>] [-All]
 [-IncludeServices] [<CommonParameters>]
```

## DESCRIPTION

Gets one or more certificates based on a search string in order to add them e.g. to another machine or store.
Supports both Cer as well as PFX. Password is required when using PFX.

## EXAMPLES

### Example 1
```powershell
PS C:\> $bytes = Invoke-Command SomeHost { Get-Certificate2 -SearchString japete -FindType FindBySubjectName -Location CERT_SYSTEM_STORE_CURRENT_USER -Store My} | Add-Certificate2
```

Remotely retrieves the certificate for CN=japete and installs it locally.

## PARAMETERS

### -SearchString

The search string to use. For more information, see: https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.x509certificate2collection.find

```yaml
Type: String
Parameter Sets: FindCer, FindPfx
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FindType

Sets which attribute will be searched, e.g. FindBySubjectName

```yaml
Type: X509FindType
Parameter Sets: FindCer, FindPfx
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location

The location to search in. Possible values CERT_SYSTEM_STORE_CURRENT_USER, CERT_SYSTEM_STORE_LOCAL_MACHINE, CERT_SYSTEM_STORE_SERVICES, CERT_SYSTEM_STORE_USERS

```yaml
Type: CertStoreLocation
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Store

The store to look in, e.g. My

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceName

The name of the service

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

### -Password

The password used to decrypt the PFX private key

```yaml
Type: SecureString
Parameter Sets: FindPfx, AllPfx
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -All

Retrieve all certificates

```yaml
Type: SwitchParameter
Parameter Sets: AllPfx, AllCer
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeServices

Indicates that services will be included

```yaml
Type: SwitchParameter
Parameter Sets: AllPfx, AllCer
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExportPrivateKey

Indicates that the private key should be exported for a PFX certificate

```yaml
Type: SwitchParameter
Parameter Sets: FindPfx, AllPfx
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
