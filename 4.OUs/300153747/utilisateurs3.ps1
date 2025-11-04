# ETAPE 5 : Désactiver un utilisateur
Disable-ADAccount -Identity "alice.dupont" -Server $domainName

# ETAPE 6 : Réactiver un utilisateur
Enable-ADAccount -Identity "alice.dupont" -Server $domainName

# ETAPE 7 : Supprimer un utilisateur
Remove-ADUser -Identity "alice.dupont" -Server $domainName -Confirm:$false

# ETAPE 8 : Rechercher des utilisateurs avec un filtre
Get-ADUser -Filter "Name -like 's*'" -Server $domainName -Properties Name, SamAccountName |
Select-Object Name, SamAccountName

# ETAPE 9 : Exporter les utilisateurs dans un CSV
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
