#This script will help you with Automated DLs or pulling information for everyone under a leader's Org
#Exclude some users. Usercontrol 514-Disabled, 66048-password never expires, 66050-disabled and password never expires
Get-ADUser -LDAPFilter "(&(&(objectCategory=person)(objectClass=user))(&(&(manager:1.2.840.113556.1.4.1941:=CN=Satya Cannister,OU=Delhi,DC=dev,DC=lab,DC=com))(&(!userAccountControl=514)(!userAccountControl=66048)(!userAccountControl=66050))))"