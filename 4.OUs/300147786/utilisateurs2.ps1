# ÉTAPE 3 : Créer un nouvel utilisateur
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Server $domainName

# ÉTAPE 4 : Modifier un utilisateur
Set-ADUser -Identity "alice.dupont" `
           -Server $domainName `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie"
