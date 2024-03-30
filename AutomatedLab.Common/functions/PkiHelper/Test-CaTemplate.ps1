function Test-CATemplate
{
    [cmdletBinding()]
    [OutputType([bool])]
    param(
        [Parameter(Mandatory = $true)]
        [string]$TemplateName
    )

    $tempates = certutil.exe -Template | Select-String -Pattern TemplatePropCommonName

    $template = $tempates -like "*$TemplateName"

    return [bool]$template
}
