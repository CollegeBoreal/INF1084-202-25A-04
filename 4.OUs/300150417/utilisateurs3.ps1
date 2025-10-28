# Étape 5 : Désactiver un utilisateur
Disable-ADAccount -Identity "alice.dupont" -Credential $cred

# Étape 6 : Réactiver un utilisateur
Enable-ADAccount -Identity "alice.dupont" -Credential $cred

# Étape 8 : Rechercher les utilisateurs avec un filtre
Get-ADUser -Filter "GivenName -like 'A*'" -Properties Name, SamAccountName |
Select-Object Name, SamAccountName

# Étape 9 : Exporter la liste des utilisateurs
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
