# gestion_utilisateurs.ps1 – Activer, désactiver, supprimer, rechercher
Import-Module ActiveDirectory
. .\bootstrap.ps1

# Désactiver un utilisateur
Disable-ADAccount -Identity "alice.dupont" -Credential $cred

# Réactiver un utilisateur
Enable-ADAccount -Identity "alice.dupont" -Credential $cred

# Supprimer un utilisateur
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred

# Rechercher les utilisateurs dont le prénom commence par A
Get-ADUser -Filter "GivenName -like 'A*'" -Properties Name, SamAccountName |
Select-Object Name, SamAccountName

