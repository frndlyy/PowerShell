Get-Module ActiveDirectory | Import-Module

Get-ADUser -Identity ikhan -Properties directreports | Select-Object -ExpandProperty directreports | Get-ADUser -Properties Name,mail | Select-Object Name,mail