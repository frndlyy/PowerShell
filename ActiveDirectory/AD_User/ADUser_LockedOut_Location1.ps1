##https://gallery.technet.microsoft.com/scriptcenter/How-to-find-locked-out-1d964f6b

If($SamAccountName)
{
    Foreach($Account in $SamAccountName)
    {
        $LockedOutAccount = Get-ADUser -Filter {SamAccountName -eq $Account} -Server $DC.HostName `
        -Properties SamAccountName,AccountLockoutTime,LastBadPasswordAttempt,badPwdCount,LockedOut|`
        Where{$_.LockedOut -eq $true} | Select-Object SamAccountName,AccountLockoutTime,LastBadPasswordAttempt,badPwdCount,LockedOut
        $LockedOutInfo = $LockedOutAccount|Foreach{New-Object -TypeName PSObject `
        -Property @{SamAccountName = $_.SamAccountName;
                    LogonLocation = $($Name = $_.SamAccountName;`
                    $Objs|Where{$_.SamAccountName -eq $Name}|Sort -Unique|`
                    Select -ExpandProperty Location);
                    AccountLockoutTime = $_.AccountLockoutTime
                    LastBadPasswordAttempt = $_.LastBadPasswordAttempt;
                    badPwdCount = $_.badPwdCount}}
 
        $LockedOutInfo | Select SamAccountName,LogonLocation,AccountLockoutTime,LastBadPasswordAttempt,badPwdCount                                                                                            
    }
}