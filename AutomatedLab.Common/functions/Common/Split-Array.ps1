function Split-Array
{
    param(
        [Parameter(Mandatory = $true)]
        [System.Collections.IEnumerable]$List,

        [Parameter(Mandatory = $true, ParameterSetName = 'MaxChunkSize')]
        [Alias('ChunkSize')]
        [int]$MaxChunkSize,

        [ValidateRange(2, [long]::MaxValue)]
        [Parameter(Mandatory = $true, ParameterSetName = 'ChunkCount')]
        [int]$ChunkCount,

        [switch]$AllowEmptyChunks
    )

    if (-not $AllowEmptyChunks -and ($list.Count -lt $ChunkCount))
    {
        Write-Error "List count ($($List.Count)) is smaller than ChunkCount ($ChunkCount).)"
        return
    }

    if ($PSCmdlet.ParameterSetName -eq 'MaxChunkSize')
    {
        $ChunkCount = [Math]::Ceiling($List.Count / $MaxChunkSize)
    }
    $containers = foreach ($i in 1..$ChunkCount)
    {
        New-Object System.Collections.Generic.List[object]
    }

    $iContainer = 0
    foreach ($item in $List)
    {
        $containers[$iContainer].Add($item)
        $iContainer++
        if ($iContainer -ge $ChunkCount) {
            $iContainer = 0
        }
    }

    $containers
}
