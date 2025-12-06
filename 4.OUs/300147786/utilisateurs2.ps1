# ============================
$domainName = "DC300147786-00.local"
$netbiosName = "DC300147786-00"


# ÉTAPE 3 : CRÉER UN NOUVEL UTILISATEUR
New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Server $domainName

Write-Host "Utilisateur 'Alice Dupont' créé avec succès."

# ÉTAPE 4 : MODIFIER L'UTILISATEUR

Set-ADUser -Identity "alice.dupont" `
           -Server $domainName `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie"

Write-Host "Utilisateur 'alice.dupont' modifié avec succès."

           -GivenName "Alice-Marie"
