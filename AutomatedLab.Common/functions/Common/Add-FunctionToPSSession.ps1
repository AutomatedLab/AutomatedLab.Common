function Add-FunctionToPSSession
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
            HelpMessage = 'Provide the function info to load into the session(s)',
            Mandatory = $true,
            Position = 1,
            ValueFromPipeline	= $true
        )]
        [ValidateNotNull()]
        [System.Management.Automation.FunctionInfo]
        $FunctionInfo
    )

    begin
    {
        $cmdName = (Get-PSCallStack)[0].Command
        Write-Debug "[$cmdName] Entering function"

        $scriptBlock =
        {
            param([string]$Path, [string]$Definition)
            $null = Set-Item -Path Function:\$Path -Value $Definition
        }
    }

    process
    {
        Invoke-Command -Session $Session -ScriptBlock $scriptBlock -ArgumentList $FunctionInfo.Name, $FunctionInfo.Definition
    }

    end
    {
        Write-Debug "[$cmdName] Exiting function"
    }
}
