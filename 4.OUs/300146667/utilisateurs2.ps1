# script2_CreateUser.ps1
# Supprimer l'utilisateur existant
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred

# Puis recréer l'utilisateur

Import-Module ActiveDirectory

# Créer un compte administrateur pour les opérations sécurisées
# $cred = Get-Credential  # Saisir Administrator@$domainName

# Créer un nouvel utilisateur
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Credential $cred
