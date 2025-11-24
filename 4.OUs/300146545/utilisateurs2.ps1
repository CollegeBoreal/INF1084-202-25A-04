# ============================================
# 2. CRÉATION D'UTILISATEURS
# Étudiant: SAOUDI ALAOUA 
# ID: 300146545
# ============================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "CRÉATION D'UTILISATEURS" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Créer votre utilisateur principal
Write-Host "Création de l'utilisateur SAOUDI ALAOUA..." -ForegroundColor Yellow
New-ADUser -Name "SAOUDI ALAOUA " `
    -GivenName "SAOUDI" `
    -Surname "AllAOUA" `
    -SamAccountName "SALLAOUA" `
    -UserPrincipalName "SALLAOUA@DC300146545-00.local" `
    -Path "OU=Employes,OU=300146545,DC=DC300146545-00,DC=local" `
    -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
    -Enabled $true

# Créer un utilisateur test
Write-Host "Création de l'utilisateur Test..." -ForegroundColor Yellow
New-ADUser -Name "Utilisateur Test" `
    -GivenName "Utilisateur" `
    -Surname "Test" `
    -SamAccountName "utest" `
    -UserPrincipalName "utest@DC300146545-00.local" `
    -Path "OU=Employes,OU=300146545,DC=DC300146545-00,DC=local" `
    -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
    -Enabled $true

# Créer un utilisateur administrateur
Write-Host "Création de l'utilisateur Admin..." -ForegroundColor Yellow
New-ADUser -Name "Admin 300146545" `
    -GivenName "Admin" `
    -Surname "300146545" `
    -SamAccountName "admin300146545" `
    -UserPrincipalName "admin300146545@DC300146545-00.local" `
    -Path "OU=Employes,OU=300146545,DC=DC300146545-00,DC=local" `
    -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
    -Enabled $true

Write-Host "`n✓ Utilisateurs créés avec succès!" -ForegroundColor Green

# Vérification des utilisateurs créés
Write-Host "`nVérification des utilisateurs:" -ForegroundColor Cyan
Get-ADUser -Filter * -SearchBase "OU=Employes,OU=300146545,DC=DC300146545-00,DC=local" | 
    Select-Object Name, SamAccountName, Enabled, DistinguishedName | 
    Format-Table -AutoSize