function Enable-AutoEnrollment
{
    param
    (
        [switch]$Computer,
        [switch]$UserOrCodeSigning
    )
    
    Write-Verbose -Message "Computer: '$Computer'"
    Write-Verbose -Message "Computer: '$UserOrCodeSigning'"    
    
    if ($Computer)
    {
        Write-Verbose -Message 'Configuring for computer auto enrollment'
        [GPO.Helper]::SetGroupPolicy($true, 'Software\Policies\Microsoft\Cryptography\AutoEnrollment', 'AEPolicy', 7)
        [GPO.Helper]::SetGroupPolicy($true, 'Software\Policies\Microsoft\Cryptography\AutoEnrollment', 'OfflineExpirationPercent', 10)
        [GPO.Helper]::SetGroupPolicy($true, 'Software\Policies\Microsoft\Cryptography\AutoEnrollment', 'OfflineExpirationStoreNames', 'MY')
    }
    if ($UserOrCodeSigning)
    {
        Write-Verbose -Message 'Configuring for user auto enrollment'
        [GPO.Helper]::SetGroupPolicy($false, 'Software\Policies\Microsoft\Cryptography\AutoEnrollment', 'AEPolicy', 7)
        [GPO.Helper]::SetGroupPolicy($false, 'Software\Policies\Microsoft\Cryptography\AutoEnrollment', 'OfflineExpirationPercent', 10)
        [GPO.Helper]::SetGroupPolicy($false, 'Software\Policies\Microsoft\Cryptography\AutoEnrollment', 'OfflineExpirationStoreNames', 'MY')
    }
    
    1..3 | ForEach-Object { gpupdate.exe /force; certutil.exe -pulse; Start-Sleep -Seconds 1 }
}
