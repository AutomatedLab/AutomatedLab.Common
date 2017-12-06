function Test-CATemplate
{
    [cmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$TemplateName
    )
    
    $tempates = certutil.exe -Template | Select-String -Pattern TemplatePropCommonName

    $template = $tempates -like "*$TemplateName"

    return [bool]$template
}
