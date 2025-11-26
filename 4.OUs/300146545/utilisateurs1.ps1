# ============================================
# 1. CRÉATION DE LA STRUCTURE DES OUs
# Étudiant: saoudi alaoua 
# ID: 300146545
# ============================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "CRÉATION DE LA STRUCTURE DES OUs" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Créer l'OU principale avec votre ID
Write-Host "Création de l'OU principale 300146545..." -ForegroundColor Yellow
New-ADOrganizationalUnit -Name "300146545" -Path "DC=DC300146545-00,DC=local"

# Créer l'OU pour les employés
Write-Host "Création de l'OU Employes..." -ForegroundColor Yellow
New-ADOrganizationalUnit -Name "Employes" -Path "OU=300146545,DC=DC300150295-00,DC=local"

# Créer l'OU pour les ordinateurs
Write-Host "Création de l'OU Ordinateurs..." -ForegroundColor Yellow
New-ADOrganizationalUnit -Name "Ordinateurs" -Path "OU=300146545,DC=DC300146545-00,DC=local"

Write-Host "`n✓ Structure des OUs créée avec succès!" -ForegroundColor Green

# Vérification de la structure créée
Write-Host "`nVérification de la structure:" -ForegroundColor Cyan
Get-ADOrganizationalUnit -Filter 'Name -like "*300146545*"' | 
    Select-Object Name, DistinguishedName | 
    Format-Table -AutoSize