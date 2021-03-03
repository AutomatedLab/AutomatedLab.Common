function Add-VariableToPSSession
{
    [CmdletBinding(
        SupportsShouldProcess = $false,
        ConfirmImpact = 'None'
    )]

    param
    ( 
        [Parameter(
            HelpMessage	= 'Provide the session(s) to load the functions into', 
            Mandatory	= $true,
            Position	= 0
        )]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.Runspaces.PSSession[]] 
        $Session,

        [Parameter( 
            HelpMessage = 'Provide the variable info to load into the session(s)', 
            Mandatory = $true, 
            Position = 1, 
            ValueFromPipeline	= $true 
        )]
        [ValidateNotNull()]
        [System.Management.Automation.PSVariable]
        $PSVariable
    )

    begin 
    {
        $cmdName = (Get-PSCallStack)[0].Command
        Write-Debug "[$cmdName] Entering function"

        $scriptBlock = 
        {
            param([string]$_AL_Path, [object]$Value)
            $null = Set-Item -Path Variable:\$_AL_Path -Value $Value
        }
    }

    process
    {
        if ($PSVariable.Name -eq 'PSBoundParameters')
        {
            Invoke-Command -Session $Session -ScriptBlock $scriptBlock -ArgumentList 'ALBoundParameters', $PSVariable.Value
        }
        else
        {
            Invoke-Command -Session $Session -ScriptBlock $scriptBlock -ArgumentList $PSVariable.Name, $PSVariable.Value
        }
    }

    end
    {
        Write-Debug "[$cmdName] Exiting function"
    }
}
