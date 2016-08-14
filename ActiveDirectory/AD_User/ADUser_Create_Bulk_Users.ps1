#OU Where the users need to be created
$Path = "OU=Marketing,OU=AllUsers,DC=AutomationJunkie,DC=com"

#import the CSV with list of users
$Accounts = Import-Csv C:\Temp\Users.csv
#if your csv does not have headers 
#$Accounts = Import-Csv C:\Temp\Users.csv -Header @("DisplayName","Userprincipalname","givenname","sn","SamAccountName","Name","employeeID")
foreach ($line in $Accounts)
{
#Lets create the Users and input the name, display name, description and first name
New-ADUser -Path $Path -Name $line.Name -SamAccountName $line.SamAccountName -DisplayName $line.DisplayName -GivenName $line.givenname -Surname $line.sn -UserPrincipalName $line.Userprincipalname -EmployeeID $line.employeeID -ChangePasswordAtLogon $true -Enabled $True -AccountPassword (ConvertTo-SecureString -AsPlainText "SuperSecure@123!!!" -Force) -Verbose
}

#if you need to reset their password
Set-ADAccountPassword  -Identity $line.Name -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "SuperSecure@123!!!" -Force)