function Get-FullMesh
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [array]$List,

        [switch]$OneWay
    )

    $mesh = New-Object System.Collections.ArrayList

    foreach ($item1 in $List)
    {
        foreach ($item2 in $list)
        {
            if ($item1 -eq $item2)
            { continue }

            if ($mesh.Contains(($item1, $item2)))
            { continue }

            if ($OneWay)
            {
                if ($mesh.Contains(($item2, $item1)))
                { continue }
            }

            $mesh.Add((New-Object (Get-Type -GenericType Mesh.Item -T string) -Property @{ Source = $item1; Destination = $item2 } )) | Out-Null
        }
    }

    $mesh
}
