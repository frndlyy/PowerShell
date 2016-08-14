Import-Module AciveDirectory

#Force the password to expire. use the user's distinguishedName
Set-ADUser "CN=Nikki Bella,OU=RealEstate,OU=AllUsers,DC=AutomationJunkie,DC=com" -Replace @{pwdLastSet='0'}

#Get info is password is expired
Get-ADUser "CN=John Cena,OU=WeightLifting,OU=AllUsers,DC=AutomationJunkie,DC=com" -Properties PasswordExpired | Select-Object PasswordExpired