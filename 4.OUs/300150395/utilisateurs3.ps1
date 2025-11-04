# TP Active Directory - Partie 3
# Gestion des comptes


Disable-ADAccount -Identity "alice.dupont" -Server $domainName
Enable-ADAccount -Identity "alice.dupont" -Server $domainName
Remove-ADUser -Identity "alice.dupont" -Server $domainName -Confirm:$false

Get-ADUser -Filter "Name -like 'a*'" -Server $domainName -Properties Name, SamAccountName |
Select-Object Name, SamAccountName

Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
