function Send-ModuleToPSSession
{
    [CmdletBinding(  
        RemotingCapability = 'PowerShell', #V3 and above, values documented here: http://msdn.microsoft.com/en-us/library/system.management.automation.remotingcapability(v=vs.85).aspx
        SupportsShouldProcess = $false,
        ConfirmImpact = 'None',
        DefaultParameterSetName = ''
    )]
    
    [OutputType([System.IO.FileInfo])] #OutputType is supported in 3.0 and above
     
    param
    (
        [Parameter(
            HelpMessage = 'Provide the source module info object',
            Position = 0,
            Mandatory = $true, 
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]
        [PSModuleInfo]
        $Module,

        [Parameter(
            HelpMessage = 'Enter the destination path on the remote computer',
            Position = 1,
            Mandatory = $true, 
            ValueFromPipelineByPropertyName = $true
        )]
        [System.Management.Automation.Runspaces.PSSession[]] 
        $Session,
        
        [ValidateSet('AllUsers', 'CurrentUser')]
        [string]
        $Scope = 'AllUsers',

        [switch]
        $IncludeDependencies,

        [switch]
        $Move,

        [switch]
        $Encrypt,

        [switch]
        $NoWriteBuffer,

        [switch]
        $Verify,

        [switch]
        $NoClobber,

        [ValidateRange(1KB, 7.4MB)] #might be good to have much higher top end as the underlying max is controlled by New-PSSessionOption
        [uint32]
        $MaxBufferSize = 1MB
    )

    begin
    {
        $isCalledRecursivly = (Get-PSCallStack | Where-Object Command -eq $MyInvocation.InvocationName | Measure-Object | Select-Object -ExpandProperty Count) -gt 1
    }
    
    process
    {
        $fileParams = ([hashtable]$PSBoundParameters).Clone()
        [void]$fileParams.Remove('Module')
        [void]$fileParams.Remove('Scope')
        [void]$fileParams.Remove('IncludeDependencies')
        
        if ($Local:Module.ModuleType -eq 'Script' -and ($Local:Module.Path -notmatch '\.psd1$'))
        {
            Write-Error "Cannot send the module '$($Module.Name)' that is not described by a .psd1 file"
            return
        }

        #Remove any sessions where the same or newer module version already exists
        if (-not $Force)
        {
            Write-Verbose 'Filtering out target sessions that do not need the module'
            $Session = foreach ($item in $PSBoundParameters.Session)
            {
                #recursive calls will need to refresh the cached module list because we may have just placed new modules there
                if ($isCalledRecursivly)
                {
                    $modules = Get-Module -PSSession $item -ListAvailable -Name $Local:Module.Name -Refresh
                }
                else
                {
                    $modules = Get-Module -PSSession $item -ListAvailable -Name $Local:Module.Name
                }
                    
                #no version of the module installed, select for sending
                if (-not $modules)
                {
                    $item
                }
                else
                {
                    #determine what versions we have
                    $versions = $modules | ForEach-Object { [System.Version]$_.Version } | Sort-Object -Unique -Descending
                    $highestVersion = $versions | Select-Object -First 1

                    #if the version we are sending is newer than the highest installed version, select for sending
                    if ([System.Version]$Local:Module.Version -gt $highestVersion)
                    {
                        $item
                    }
                    elseif ($highestVersion -gt [System.Version]$Local:Module.Version)
                    {
                        write-Warning "Skipping $($item.ComputerName) which has a higher version $highestVersion of the module installed"
                    }
                    else
                    {
                        write-Verbose  "Skipping $($item.ComputerName) because the same version of the module is installed already"
                    }
                }
            }
        }

        foreach ($s in $Session)
        {
            $destination = if ($Scope -eq 'AllUsers')
            {
                Invoke-Command -Session $s -ScriptBlock {
                    $destination = Join-Path -Path ([System.Environment]::GetFolderPath('ProgramFiles')) -ChildPath WindowsPowerShell\Modules
                    if (-not (Test-Path -Path $destination))
                    {
                        mkdir -Path $destination -Force | Out-Null
                    }
                    $destination
                }
            }
            else
            {
                Invoke-Command -Session $s -ScriptBlock { 
                    $destination = Join-Path -Path ([System.Environment]::GetFolderPath('MyDocuments')) -ChildPath WindowsPowerShell\Modules
                    if (-not (Test-Path -Path $destination))
                    {
                        mkdir -Path $destination -Force | Out-Null
                    }
                    $destination
                }
            }

            Write-Verbose "Sending psd1 manifest module in directory $($Local:Module.ModuleBase)"

            if ($Local:Module.ModuleBase -match '\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}$' -or $Local:Module.ModuleBase -match '\d{1,4}\.\d{1,4}\.\d{1,4}$')
            {
                #parent folder contains a specific version. In order to copy the module right, the parent of this parent is required
                $Local:moduleParentFolder = Split-Path -Path $Local:Module.ModuleBase -Parent
            }
            else
            {
                $Local:moduleParentFolder = $Local:Module.ModuleBase
            }
            
            Send-Directory -SourceFolderPath $Local:moduleParentFolder -DestinationFolderPath $destination -Session $s

            if ($PSBoundParameters.IncludeDependencies -and ($Local:Module.RequiredAssemblies -or $Local:Module.RequiredModules))
            {
                foreach ($requiredModule in $Module.RequiredModules)
                {
                    $requiredModule = Get-Module -ListAvailable $requiredModule | Sort-Object Version -Descending | Select-Object -First 1
                    $params = ([hashtable]$PSBoundParameters).Clone()
                    [void]$params.Remove('Module')
                    Send-ModuleToPSSession -Module $requiredModule @params
                }

                foreach ($requiredAssembly in $Local:Module.RequiredAssemblies)
                {
                    if (Test-Path -Path $requiredAssembly)
                    {
                        Send-FileToPSSession -Source (Get-Item -Path $requiredAssembly -Force).FullName @fileParams
                    }
                    else
                    {
                        write-Warning "Sending required assemblies that do not have the full path information is not currently supported, $requiredAssembly not sent"
                    }
                }
            }
        }
    }
    
    end
    {
    }
}
