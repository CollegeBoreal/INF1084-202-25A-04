# script2_CreateUser.ps1
# Supprimer l'utilisateur existant
Remove-ADUser -Identity "alice.dupont" -Confirm:$false -Credential $cred

# Puis recréer l'utilisateur

$studentNumber = 300141429
$studentInstance = 00
$domainName = "DC300141429.local"
$netbiosName = "DC300141429"

Import-Module ActiveDirectory

# Créer un compte administrateur pour les opérations sécurisées
$cred = Get-Credential  # Saisir Administrator@$domainName

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

