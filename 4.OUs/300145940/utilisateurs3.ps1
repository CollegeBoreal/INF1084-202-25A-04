# ------------------------------------------------------------------------
# Section 3 : Déploiement des objets ordinateurs dans l’Active Directory
# Étudiante : Tasnim
# Identifiant : 300145940
# ------------------------------------------------------------------------

Write-Host "`n----------------------------------------" -ForegroundColor Cyan
Write-Host "GÉNÉRATION DES POSTES INFORMATIQUES" -ForegroundColor Cyan
Write-Host "----------------------------------------`n" -ForegroundColor Cyan

# Ajout de postes de bureau dans l’unité Ordinateurs
Write-Host "→ Ajout du poste PC-300145940-01..." -ForegroundColor Yellow
New-ADComputer -Name "PC-300145940-01" -Path "OU=Ordinateurs,OU=300145940,DC=DC300145940-00,DC=local"

Write-Host "→ Ajout du poste PC-300145940-02..." -ForegroundColor Yellow
New-ADComputer -Name "PC-300145940-02" -Path "OU=Ordinateurs,OU=300145940,DC=DC300145940-00,DC=local"

# Ajout des ordinateurs portables dans la même unité
Write-Host "→ Ajout du portable LAPTOP-300145940-01..." -ForegroundColor Yellow
New-ADComputer -Name "LAPTOP-300145940-01" -Path "OU=Ordinateurs,OU=300145940,DC=DC300145940-00,DC=local"

Write-Host "→ Ajout du portable LAPTOP-300145940-02..." -ForegroundColor Yellow
New-ADComputer -Name "LAPTOP-300145940-02" -Path "OU=Ordinateurs,OU=300145940,DC=DC300145940-00,DC=local"

# Ajout d’un serveur
Write-Host "→ Déclaration du serveur SRV-300145940-01..." -ForegroundColor Yellow
New-ADComputer -Name "SRV-300145940-01" -Path "OU=Ordinateurs,OU=300145940,DC=DC300145940-00,DC=local"

Write-Host "`n✔ Les objets ordinateurs ont été créés avec succès !" -ForegroundColor Green

# Contrôle de la liste des ordinateurs ajoutés
Write-Host "`nListe des ordinateurs enregistrés :" -ForegroundColor Cyan
Get-ADComputer -Filter * -SearchBase "OU=Ordinateurs,OU=300145940,DC=DC300145940-00,DC=local" |
    Select-Object Name, DNSHostName, DistinguishedName |
    Format-Table -AutoSize

