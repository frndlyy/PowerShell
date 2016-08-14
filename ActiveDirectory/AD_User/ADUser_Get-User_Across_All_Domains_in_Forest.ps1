#Get Domain List and load user e-mails from file
Get-Module ActiveDirectory | Import-Module
$objForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
$DomainList = @($objForest.Domains | Select-Object Name)
$Domains = $DomainList | foreach {$_.Name}
$Users = Import-CSV c:\temp\evamarie\TEST.csv

#Act on each domain
foreach($Domain in $Domains) 
{
Write-Host "Checking $Domain" -fore red

foreach ($line in $users) 
{ 
Get-ADUser -identity $line.SamAccountName -Server $domain -Properties "Name" | select-object -ExpandProperty  "Name"
}
}
