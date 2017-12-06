function Invoke-Ternary 
{
    param
    (
        [scriptblock]
        $decider,

        [scriptblock]
        $ifTrue,

        [scriptblock]
        $ifFalse
    )

    if (&$decider)
    {
        &$ifTrue
    }
    else
    {
        &$ifFalse
    }
}
Set-Alias -Name ?? -Value Invoke-Ternary -Option AllScope -Description "Ternary Operator like '?' in C#" -Scope Global
