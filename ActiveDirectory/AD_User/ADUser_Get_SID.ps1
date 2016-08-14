#Resolve or get SID for Active Directory object

#Resolve object SID to username
$objSID = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-21-123456789-1234567890-123456789-12345") $objUser = $objSID.Translate( [System.Security.Principal.NTAccount]) $objUser.Value
	
$objSID = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-21-123456789-1234567890-123456789-12345")
$objUser = $objSID.Translate( [System.Security.Principal.NTAccount])
$objUser.Value

#Get SID of a username
get-aduser "username" -Properties sid | select sid
#Script (with Quest Active Directory module) :
Get-QADUser "username" -IncludedProperties sid |select sid