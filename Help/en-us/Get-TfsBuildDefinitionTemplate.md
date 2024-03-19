---
external help file: AutomatedLab.Common-Help.xml
Module Name: AutomatedLab.Common
online version:
schema: 2.0.0
---

# Get-TfsBuildDefinitionTemplate

## SYNOPSIS
Gets all build definition templates

## SYNTAX

### Cred (Default)
```
Get-TfsBuildDefinitionTemplate -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 [-ApiVersion <String>] -ProjectName <String> [-UseSsl] -Credential <PSCredential> [-SkipCertificateCheck]
 [<CommonParameters>]
```

### Pat
```
Get-TfsBuildDefinitionTemplate -InstanceName <String> [-CollectionName <String>] [-Port <UInt32>]
 [-ApiVersion <String>] -ProjectName <String> [-UseSsl] -PersonalAccessToken <String> [-SkipCertificateCheck]
 [<CommonParameters>]
```

## DESCRIPTION
Gets all build definition templates

## EXAMPLES

### List all build definition templates
```
Get-TfsBuildDefinitionTemplate -InstanceName 'dsc1tfs1' -CollectionName automatedlab -ProjectName someNewname -Credential $cred
```

Gets all possible build definition templates

id          : vsBuild name        : Visual Studio canDelete   : False category    : Build iconTaskId  : 71a9a2d3-a98a-4caa-96ab-affca411ecda description : Build and run tests using Visual Studio.
This template requires that Visual Studio be installed on the build agent.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : UniversalWindowsPlatform name        : Universal Windows Platform canDelete   : False category    : Build iconTaskId  : 71a9a2d3-a98a-4caa-96ab-affca411ecda description : Build Universal Windows Platform applications using Visual Studio.
This template requires that Visual Studio and the Universal templates are installed on the build agent.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : AzureCloud name        : Azure Cloud Services canDelete   : False category    : Deployment iconTaskId  : 2ca8fe15-42ea-4b26-80f1-e0738ec17e89 description : Build, package, test and deploy your Azure Cloud Service.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : AzureWeb name        : Azure WebApp canDelete   : False category    : Deployment iconTaskId  : dcbef2c9-e4f4-4929-82b2-ea7fc9166109 description : Build, package, test and deploy your Azure WebApp.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : Xcode name        : Xcode canDelete   : False category    : Build iconTaskId  : 1e78dc1b-9132-4b18-9c75-0e7ecc634b74 description : Build and test an Xcode workspace.
This template requires a Mac OS build agent.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : blank name        : Empty canDelete   : False category    : Empty description : Start with a definition that has no steps.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; jobAuthorizationScope=projectCollection; type=build}

id          : XamarinAndroid name        : Xamarin.Android canDelete   : False category    : Build iconTaskId  : 27edd013-36fd-43aa-96a3-7d73e1e35285 description : Build an Android app and Xamarin.UITest assembly.
Test with Xamarin Test Cloud.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : XamariniOS name        : Xamarin.iOS canDelete   : False category    : Build iconTaskId  : 0f077e3a-af59-496d-81bc-ad971b7464e0 description : Build a Xamarin.iOS app and Xamarin.UITest assembly.
Test with Xamarin Test Cloud.
This template requires a Mac OS build agent.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : BuildDeployDistributedTest name        : Build, Deploy and Distributed Test canDelete   : False category    : Deployment iconTaskId  : 52a38a6a-1517-41d7-96cc-73ee0c60d2b6 description : Build, deploy and distribute tests on a set of remote machines using Visual Studio Test Agent.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : android name        : Android canDelete   : False category    : Build iconTaskId  : df857559-8715-46eb-a74e-ac98b9178aa0 description : Build your Android projects, run tests, sign and align Android App Package files.
This template requires the Android SDK to be installed on the build agent.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : ant name        : Ant canDelete   : False category    : Build iconTaskId  : 3a6a2d63-f2b2-4e93-bcf9-0cbe22f5dc26 description : Build your Java projects and run tests with Apache Ant.
This template requires Ant to be installed on the build agent.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : gradle name        : Gradle canDelete   : False category    : Build iconTaskId  : 8d8eebd8-2b94-4c97-85af-839254cc6da4 description : Build your Java projects and run tests with Gradle using a Gradle wrapper script.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : maven name        : Maven canDelete   : False category    : Build iconTaskId  : ac4ee482-65da-4485-a532-7b085873e532 description : Build your Java projects and run tests with Apache Maven.
This template requires Maven to be installed on the build agent.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : ServiceFabricApplication name        : Azure Service Fabric Application canDelete   : False category    : Build iconTaskId  : 97ef6e59-b8cc-48aa-9937-1a01e35e7584 description : Build and package an Azure Service Fabric application.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : jenkins name        : Jenkins canDelete   : False category    : Build iconTaskId  : c24b86d4-4256-4925-9a29-246f81aa64a7 description : Queue a Jenkins job and download its artifacts.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

id          : AzureIaaS name        : Load test using Azure IaaS virtual machines canDelete   : False category    : Deployment iconTaskId  : 9e9db38a-b40b-4c13-b7f0-31031c894c22 description : Create your own rig on Azure IaaS virtual machines to run load tests using VSTS cloud-based load testing service.
template    : @{build=System.Object\[\]; options=System.Object\[\]; triggers=System.Object\[\]; variables=; buildNumberFormat=$(date:yyyyMMdd)$(rev:.r); jobAuthorizationScope=projectCollection; type=build}

## PARAMETERS

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

### -SkipCertificateCheck
Skip certificate validation

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

### -UseSsl
Indicates that SSL should be used

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
