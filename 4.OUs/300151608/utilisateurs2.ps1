. $(Join-Path  'bootstrap.ps1')
Import-Module ActiveDirectory

# Créer utilisateur dans CN=Users (par défaut)
New-ADUser -Name "Alice Dupont" 
  -GivenName "Alice" 
  -Surname "Dupont" 
  -SamAccountName "alice.dupont" 
  -UserPrincipalName "alice.dupont@" 
  -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) 
  -Enabled True 
  -Path "CN=Users,DC=,DC=local" 
  -Credential 

# Modifier quelques attributs
Set-ADUser -Identity "alice.dupont" -EmailAddress "alice.dupont@example.com" -GivenName "Alice-Marie" -Credential 
