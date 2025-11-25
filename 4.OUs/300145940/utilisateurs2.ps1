# ------------------------------------------------------------------
# Création des unités d’organisation (OUs) – Script personnalisé
# Étudiante : Tasnim
# Numéro : 300145940
# ------------------------------------------------------------------

Write-Host "`n----------------------------------------" -ForegroundColor Cyan
Write-Host "Initialisation de l’arborescence des OUs" -ForegroundColor Cyan
Write-Host "----------------------------------------`n" -ForegroundColor Cyan

# OU principale associée à l'étudiante
Write-Host "→ Mise en place de l’OU racine 300145940..." -ForegroundColor Yellow
New-ADOrganizationalUnit -Name "300145940" -Path "DC=DC300145940-00,DC=local"

# Sous-OU destinée aux comptes employés
Write-Host "→ Création de l’unité Employes..." -ForegroundColor Yellow
New-ADOrganizationalUnit -Name "Employes" -Path "OU=300145940,DC=DC300145940-00,DC=local"

# Sous-OU destinée aux ordinateurs du domaine
Write-Host "→ Mise en place de l’unité Ordinateurs..." -ForegroundColor Yellow
New-ADOrganizationalUnit -Name "Ordinateurs" -Path "OU=300145940,DC=DC300145940-00,DC=local"

Write-Host "`n✔ Les unités d’organisation ont été générées avec succès!" -ForegroundColor Green

# Affichage de la structure créée pour vérification
Write-Host "`nAffichage des OUs associées à l’ID 300145940 :" -ForegroundColor Cyan
Get-ADOrganizationalUnit -Filter 'Name -like "*300145940*"' |
    Select-Object Name, DistinguishedName |
    Format-Table -AutoSize

