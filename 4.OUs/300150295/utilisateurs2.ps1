# ============================================
# 2. CRÉATION D'UTILISATEURS
# Étudiant: Lounas Allouti
# ID: 300150295
# ============================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "CRÉATION D'UTILISATEURS" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Créer votre utilisateur principal
Write-Host "Création de l'utilisateur Lounas Allouti..." -ForegroundColor Yellow
New-ADUser -Name "Lounas Allouti" `
    -GivenName "Lounas" `
    -Surname "Allouti" `
    -SamAccountName "lallouti" `
    -UserPrincipalName "lallouti@DC300150295-00.local" `
    -Path "OU=Employes,OU=300150295,DC=DC300150295-00,DC=local" `
    -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
    -Enabled $true

# Créer un utilisateur test
Write-Host "Création de l'utilisateur Test..." -ForegroundColor Yellow
New-ADUser -Name "Utilisateur Test" `
    -GivenName "Utilisateur" `
    -Surname "Test" `
    -SamAccountName "utest" `
    -UserPrincipalName "utest@DC300150295-00.local" `
    -Path "OU=Employes,OU=300150295,DC=DC300150295-00,DC=local" `
    -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
    -Enabled $true

# Créer un utilisateur administrateur
Write-Host "Création de l'utilisateur Admin..." -ForegroundColor Yellow
New-ADUser -Name "Admin 300150295" `
    -GivenName "Admin" `
    -Surname "300150295" `
    -SamAccountName "admin300150295" `
    -UserPrincipalName "admin300150295@DC300150295-00.local" `
    -Path "OU=Employes,OU=300150295,DC=DC300150295-00,DC=local" `
    -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
    -Enabled $true 

Write-Host "`n✓ Utilisateurs créés avec succès!" -ForegroundColor Green

# Vérification des utilisateurs créés
Write-Host "`nVérification des utilisateurs:" -ForegroundColor Cyan
Get-ADUser -Filter * -SearchBase "OU=Employes,OU=300150295,DC=DC300150295-00,DC=local" | 
    Select-Object Name, SamAccountName, Enabled, DistinguishedName | 
    Format-Table -AutoSize
