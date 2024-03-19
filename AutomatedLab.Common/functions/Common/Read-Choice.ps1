function Read-Choice
{
    param(
        [Parameter(Mandatory = $true)]
        [String[]]$ChoiceList,

        [Parameter(Mandatory = $true)]
        [String]$Caption,

        [String]$Message,

        [int]$Default = 0
    )

    if (-not $Message) { $Message = $Caption }

    $choices = New-Object System.Collections.ObjectModel.Collection[System.Management.Automation.Host.ChoiceDescription]

    $choiceList | ForEach-Object { $choices.Add((New-Object "System.Management.Automation.Host.ChoiceDescription" -ArgumentList $_)) }

    $Host.UI.PromptForChoice($Caption, $Message, $choices, $Default)
}
