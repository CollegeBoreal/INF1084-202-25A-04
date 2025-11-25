# Définir le domaine
. .\bootstrap.ps1

# Créer un nouvel utilisateur
New-ADUser `
    -Name "Alice Dupont" `
    -GivenName "Alice" `
    -Surname "Dupont" `
    -SamAccountName "alice.dupont" `
    -UserPrincipalName "alice.dupont@$domainName" `
    -Path "CN=Users,DC=DC300151042-00,DC=local" `
    -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
    -Enabled $true

# Modifier une propriété
Set-ADUser -Identity "alice.dupont" -Description "Utilisateur de test"

# Désactiver le compte
Disable-ADAccount -Identity "alice.dupont"

# Réactiver le compte
Enable-ADAccount -Identity "alice.dupont"

# Supprimer le compte
Remove-ADUser -Identity "alice.dupont" -Confirm:$false

