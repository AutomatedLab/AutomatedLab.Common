function Get-ConsoleText
{
    [CmdletBinding()]
    param()
    
    # Check the host name and exit if the host is not the Windows PowerShell console host. 
    if ($host.Name -eq 'Windows PowerShell ISE Host')
    { 
        $psISE.CurrentPowerShellTab.ConsolePane.Text
    }
    elseif ($host.Name -eq 'ConsoleHost')
    {
        $textBuilderConsole = New-Object System.Text.StringBuilder
        $textBuilderLine = New-Object System.Text.StringBuilder

        # Grab the console screen buffer contents using the Host console API.
        $bufferWidth = $host.UI.RawUI.BufferSize.Width
        $bufferHeight = $host.UI.RawUI.CursorPosition.Y 
        $rec = New-Object System.Management.Automation.Host.Rectangle(0, 0, ($bufferWidth), $bufferHeight)
        $buffer = $host.UI.RawUI.GetBufferContents($rec) 

        # Iterate through the lines in the console buffer. 
        for ($i = 0; $i -lt $bufferHeight; $i++) 
        { 
            for ($j = 0; $j -lt $bufferWidth; $j++) 
            { 
                $cell = $buffer[$i, $j] 
                $null = $textBuilderLine.Append($cell.Character)
            }
            $null = $textBuilderConsole.AppendLine($textBuilderLine.ToString().TrimEnd())
            $textBuilderLine = New-Object System.Text.StringBuilder
        }

        $textBuilderConsole.ToString()
        Write-Verbose "$bufferHeight lines have been copied to the clipboard"
    }
}
