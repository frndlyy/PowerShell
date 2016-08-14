#requires -version 3.0

<#-----------------------------------------------------------------------------
Group Membership History For A User
Ashley McGlone, Microsoft Premier Field Engineer
http://blogs.technet.com/b/ashleymcglone
October, 2012

Requires:
*PowerShell v3
*Active Directory Module for 2012

LEGAL DISCLAIMER
This Sample Code is provided for the purpose of illustration only and is not
intended to be used in a production environment.  THIS SAMPLE CODE AND ANY
RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.  We grant You a
nonexclusive, royalty-free right to use and modify the Sample Code and to
reproduce and distribute the object code form of the Sample Code, provided
that You agree: (i) to not use Our name, logo, or trademarks to market Your
software product in which the Sample Code is embedded; (ii) to include a valid
copyright notice on Your software product in which the Sample Code is embedded;
and (iii) to indemnify, hold harmless, and defend Us and Our suppliers from and
against any claims or lawsuits, including attorneys’ fees, that arise or result
from the use or distribution of the Sample Code.
 
This posting is provided "AS IS" with no warranties, and confers no rights. Use
of included script samples are subject to the terms specified
at http://www.microsoft.com/info/cpyright.htm.
-----------------------------------------------------------------------------#>

# Show a user's group memberships and the dates they were added to those groups.

Import-Module ActiveDirectory

$username = "anlan"
$userobj  = Get-ADUser $username

Get-ADUser $userobj.DistinguishedName -Properties memberOf |
 Select-Object -ExpandProperty memberOf |
 ForEach-Object {
    Get-ADReplicationAttributeMetadata $_ -Server localhost -ShowAllLinkedValues | 
      Where-Object {$_.AttributeName -eq 'member' -and 
      $_.AttributeValue -eq $userobj.DistinguishedName} |
      Select-Object FirstOriginatingCreateTime, Object, AttributeValue
    } | Sort-Object FirstOriginatingCreateTime -Descending | Out-GridView

###############################################################################
# Here are some one-liners for exploring:
Get-ADUser 'CN=anlan,OU=Migrated,DC=CohoVineyard,DC=com' -Properties memberOf
Get-ADGroup 'CN=Legal,OU=Groups,DC=CohoVineyard,DC=com' -Properties member, members, memberOf
Get-ADReplicationAttributeMetadata 'CN=Legal,OU=Groups,DC=CohoVineyard,DC=com' -Server localhost -ShowAllLinkedValues | Out-GridView
###############################################################################
# This works at the cmd line but not in PS console.
# However, it does not include the date data.
Repadmin.exe /showobjmeta localhost "CN=Legal,OU=Migrated,DC=CohoVineyard,DC=com" | find /i "anlan"
###############################################################################
