function Add-StringIncrement
{
    # .ExternalHelp AutomatedLab.Help.xml
    param(
        [Parameter(Mandatory = $true)]
        [string]$String
    )
    
    $testNumberPattern = '^(?<text>.*?) (?<number>\d+)$'
    
    $result = $String -match $testNumberPattern
    
    if ($Matches.Number)
    {
        $String = $String.Substring(0, $String.Length - $Matches.Number.Length) + ([int]$Matches.Number + 1)
    }
    else
    {
        $String = $String + ' 0'
    }
    
    $String
}
