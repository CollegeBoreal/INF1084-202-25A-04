# script3_ManageUser.ps1

$studentNumber = 300141429
$studentInstance = 00
$domainName = "DC300141429x.local"

Import-Module ActiveDirectory
$cred = Get-Credential  # Saisir Administrator@$domainName

# Modifier un utilisateur
Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Credential $cred

# Désactiver l'utilisateur
Disable-ADAccount -Identity "alice.dupont" -Credential $cred

# Réactiver l'utilisateur
Enable-ADAccount -Identity "alice.dupont" -Credential $cred

# Supprimer l'utilisateur
# Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred

