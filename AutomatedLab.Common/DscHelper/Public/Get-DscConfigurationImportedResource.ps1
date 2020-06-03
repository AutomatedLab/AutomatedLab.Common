function Get-DscConfigurationImportedResource
{
    param(
        [Parameter(Mandatory, ParameterSetName = 'ByFile')]
        [string]$FilePath,
        
        [Parameter(Mandatory, ParameterSetName = 'ByConfiguration')]
        [System.Management.Automation.ConfigurationInfo]$Configuration
    )

    if ($PSEdition -eq 'Core')
    {
        Write-Warning -Message 'Get-DscConfigurationImportedResource is not compatible with PowerShell Core.'
        return
    }
    
    $modules = New-Object System.Collections.ArrayList

    if ($Configuration)
    {
        $ast = $Configuration.ScriptBlock.Ast
        $FilePath = $ast.FindAll( { $args[0] -is [System.Management.Automation.Language.ScriptBlockAst] }, $true)[0].Extent.File
        if (-not $FilePath)
        {
            Write-Error "The configuration '$Name' could not be found in a file. Please put the configuration into a file and try again."
            return
        }
    }
    
    $ast = [scriptblock]::Create((Get-Content -Path $FilePath -Raw)).Ast
    
    $configurations = $ast.FindAll( { $args[0] -is [System.Management.Automation.Language.ConfigurationDefinitionAst] }, $true)
    Write-Verbose "Script knwos about $($configurations.Count) configurations"
    foreach ($c in $configurations)
    {
        $importCmds = $c.Body.ScriptBlock.FindAll( { $args[0].Value -eq 'Import-DscResource' -and $args[0] -is [System.Management.Automation.Language.StringConstantExpressionAst] }, $true)
        Write-Verbose "Configuration $($c.InstanceName) knows about $($importCmds.Count) Import-DscResource commands"
    
        foreach ($importCmd in $importCmds)
        {
            $commandElements = $importCmd.Parent.CommandElements | Select-Object -Skip 1 | Where-Object {$_ -is [System.Management.Automation.Language.ArrayLiteralAst] -or $_ -is [System.Management.Automation.Language.StringConstantExpressionAst] }     
            
            $moduleNames = $commandElements.SafeGetValue()
            if ($moduleNames.GetType().IsArray)
            {
                $modules.AddRange($moduleNames)
            }
            else
            {
                [void]$modules.Add($moduleNames)
            }
        }
    }
    
    $compositeResources = $modules | Where-Object { $_ -ne 'PSDesiredStateConfiguration' } | ForEach-Object { Get-DscResource -Module $_ } | Where-Object { $_.ImplementedAs -eq 'Composite' }
    foreach ($compositeResource in $compositeResources)
    {
        $modulesInResource = Get-DscConfigurationImportedResource -FilePath $compositeResource.Path
        if ($modulesInResource)
        {
            if ($modulesInResource.GetType().IsArray)
            {
                $modules.AddRange($modulesInResource)
            }
            else
            {
                [void]$modules.Add($modulesInResource)
            }
        }
    }
    
    $modules | Select-Object -Unique
}
