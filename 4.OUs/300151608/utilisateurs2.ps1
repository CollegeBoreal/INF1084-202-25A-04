. "$(Join-Path $PSScriptRoot 'bootstrap.ps1')"
Import-Module ActiveDirectory

# Créer un utilisateur dans CN=Users (par défaut)
New-ADUser -Name "Alice Dupont" `
  -GivenName "Alice" `
  -Surname "Dupont" `
  -SamAccountName "alice.dupont" `
  -UserPrincipalName "alice.dupont@$domainName" `
  -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
  -Enabled $true `
  -Path "CN=Users,DC=$netbiosName,DC=local" `
  -Credential $cred

# Modifier quelques attributs de l'utilisateur
Set-ADUser -Identity "alice.dupont" `
  -EmailAddress "alice.dupont@example.com" `
  -GivenName "Alice-Marie" `
  -Credential $cred
