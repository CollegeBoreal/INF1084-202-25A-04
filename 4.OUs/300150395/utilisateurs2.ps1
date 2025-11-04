# TP Active Directory - Partie 2
# Création et Modification d’utilisateurs


New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,DC=$netbiosName,DC=local" `
           -Server $domainName

Set-ADUser -Identity "alice.dupont" `
           -Server $domainName `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie"
