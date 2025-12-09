# ============================================
# 3. CRÉATION D'ORDINATEURS
# Étudiant: Lounas Allouti
# ID: 300150295
# ============================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "CRÉATION D'ORDINATEURS" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan
 
# Créer des postes de travail
Write-Host "Création du PC-300150295-01..." -ForegroundColor Yellow
New-ADComputer -Name "PC-300150295-01" -Path "OU=Ordinateurs,OU=300150295,DC=DC300150295-00,DC=local"

Write-Host "Création du PC-300150295-02..." -ForegroundColor Yellow
New-ADComputer -Name "PC-300150295-02" -Path "OU=Ordinateurs,OU=300150295,DC=DC300150295-00,DC=local"

# Créer des ordinateurs portables
Write-Host "Création du LAPTOP-300150295-01..." -ForegroundColor Yellow
New-ADComputer -Name "LAPTOP-300150295-01" -Path "OU=Ordinateurs,OU=300150295,DC=DC300150295-00,DC=local"

Write-Host "Création du LAPTOP-300150295-02..." -ForegroundColor Yellow
New-ADComputer -Name "LAPTOP-300150295-02" -Path "OU=Ordinateurs,OU=300150295,DC=DC300150295-00,DC=local"

# Créer un serveur
Write-Host "Création du SRV-300150295-01..." -ForegroundColor Yellow
New-ADComputer -Name "SRV-300150295-01" -Path "OU=Ordinateurs,OU=300150295,DC=DC300150295-00,DC=local"

Write-Host "`n✓ Ordinateurs créés avec succès!" -ForegroundColor Green

# Vérification des ordinateurs créés
Write-Host "`nVérification des ordinateurs:" -ForegroundColor Cyan
Get-ADComputer -Filter * -SearchBase "OU=Ordinateurs,OU=300150295,DC=DC300150295-00,DC=local" | 
    Select-Object Name, DNSHostName, DistinguishedName | 
    Format-Table -AutoSize
