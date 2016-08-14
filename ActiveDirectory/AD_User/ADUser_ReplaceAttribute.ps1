#Using native AD module
Import-Module ActiveDirectory
Set-ADUser johnsnow -Replace @{homepostaladdress='TEST_Address'}
Get-ADUser johnsnow -Property homepostaladdress | Select-Object -Property homepostaladdress

#To clear an attribute
Set-ADUser johnsnow -clear homepostaladdress

##Using Quest Active Roles Management Shell from https://support.software.dell.com/download-install-detail/5024645
Add-PSSnapin -Name Quest.ActiveRoles.ADManagement
$UserList = Import-CSV C:\temp\UserList.CSV -Header @("SamAccountName","homePostalAddress")
foreach ($line in $UserList)
{
Write-Host $line | Format-Table
Set-QADUser -Identity $line.SamAccountname -ObjectAttributes @{homepostaladdress=$line.homePostalAddress}

