# utilisateurs1.ps1
# Création de l'utilisateur Alice Dupont

. "$PSScriptRoot\bootstrap.ps1"

New-ADUser -Name "Alice Dupont" `
    -GivenName "Alice" `
    -Surname "Dupont" `
    -SamAccountName "alice.dupont" `
    -UserPrincipalName "alice.dupont@$domainName" `
    -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
    -Enabled $true `
    -Path "CN=Users,DC=$300150385-00,DC=local"
