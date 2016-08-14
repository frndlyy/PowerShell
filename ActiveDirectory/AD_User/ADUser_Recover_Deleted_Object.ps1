###Launch PowerShell as Administrator on any Domain COntroller
Import-Module ActiveDirectory
#First check if the object exists
Get-ADObject -Filter {samaccountname -eq "DwayneJohnson"} -IncludeDeletedObjects

#If it does, restore the object
Get-ADObject -Filter {samaccountname -eq "DwayneJohnson"} -IncludeDeletedObjects | Restore-ADObject