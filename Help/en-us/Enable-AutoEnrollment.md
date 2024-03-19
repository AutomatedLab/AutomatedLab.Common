---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Enable-AutoEnrollment

## SYNOPSIS
Enable certificate auto enrollment

## SYNTAX

```
Enable-AutoEnrollment [-Computer] [-UserOrCodeSigning]
```

## DESCRIPTION
Enable auto-enrollment for computer or user/codesigning certificates in local group policy

## EXAMPLES

### Example 1
```
PS C:\> Enable-AutoEnrollment -UserOrCodeSigning
```

Will enable auto enrollment for the current user

## PARAMETERS

### -Computer
Indicates that auto-enrollment should be configured for machine certificates

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserOrCodeSigning
Indicates that enrollment should be configured for user or code signing certificates

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
