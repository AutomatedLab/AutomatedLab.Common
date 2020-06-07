---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Add-Certificate2

## SYNOPSIS

Cmdlet to add a certificate to a store

## SYNTAX

### ByteArray (Default)
```
Add-Certificate2 -RawContentBytes <Byte[]> -Store <string> -Location <CertStoreLocation>
 [-ServiceName <String>] [-CertificateType <String>] [-Password <String>] [<CommonParameters>]
```

### File
```
Add-Certificate2 -Path <String> -Store <string> -Location <CertStoreLocation> [-ServiceName <String>]
 [-CertificateType <String>] [-Password <String>] [<CommonParameters>]
```

## DESCRIPTION

This cmdlet adds a certificate either by the raw byte content or by its file name to a certificate store

## EXAMPLES

### Example 1
```powershell
PS C:\> Add-Certificate2 -Path .\MyCert.cer -Store My -Location CERT_SYSTEM_STORE_CURRENT_USER
```

Imports the certificate MyCert.cer into the personal store of the current user

## PARAMETERS

### -Path

The absolute or relative path to a valid X509 certificate

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Store

The certificate store, e.g My

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Location

The certificate store location, e.g. current user

```yaml
Type: CertStoreLocation
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ServiceName

The name of the service, if the service cert store location is used

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CertificateType

The certificate type, CER or PFX

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Password

The password for the certificate

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RawContentBytes

The raw byte content of the certificate file, e.g. to execute this command remotely without a file present

```yaml
Type: Byte[]
Parameter Sets: ByteArray
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
