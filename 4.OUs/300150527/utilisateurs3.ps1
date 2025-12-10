# TP Active Directory - Partie 3
# Gestion des comptes

. .\bootstrap.ps1
Import-Module ActiveDirectory

# Désactivation du compte
Disable-ADAccount -Identity "alice.dupont" -Credential $cred

# Réactivation du compte
Enable-ADAccount -Identity "alice.dupont" -Credential $cred

# Suppression du compte
Remove-ADUser -Identity "alice.dupont" -Credential $cred -Confirm:$false

# Liste des utilisateurs dont le prénom commence par "A"
Get-ADUser -Filter "GivenName -like 'A*'" -Server "DC300150527-00.local" -Properties Name, SamAccountName |
Select-Object Name, SamAccountName

# Exportation de la liste complète des utilisateurs dans un fichier CSV
Get-ADUser -Filter * -Server "DC300150527-00.local" -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8


