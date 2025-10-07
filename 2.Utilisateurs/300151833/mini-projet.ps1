# Mini-projet : Script complet de simulation Active Directory
# Auteur : Raouf (300151833)
# Date : 2025-10-07

Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "   MINI-PROJET SIMULATION ACTIVE DIRECTORY" -ForegroundColor Magenta
Write-Host "========================================`n" -ForegroundColor Magenta

# 1. Creer 5 utilisateurs simules dans l'OU "Promo2025"
Write-Host "1. Creation de 5 utilisateurs dans l'OU 'Promo2025'..." -ForegroundColor Cyan
$Users = @(
    @{Nom="Tremblay"; Prenom="Sophie"; Login="stremblay"; OU="Promo2025"},
    @{Nom="Gagnon"; Prenom="Marc"; Login="mgagnon"; OU="Promo2025"},
    @{Nom="Roy"; Prenom="Julie"; Login="jroy"; OU="Promo2025"},
    @{Nom="Cote"; Prenom="David"; Login="dcote"; OU="Promo2025"},
    @{Nom="Bouchard"; Prenom="Emma"; Login="ebouchard"; OU="Promo2025"}
)

$Users | ForEach-Object {
    Write-Host "   OK $($_.Prenom) $($_.Nom) - $($_.Login)" -ForegroundColor Green
}

# 2. Creer un groupe "Etudiants2025"
Write-Host "`n2. Creation du groupe 'Etudiants2025'..." -ForegroundColor Cyan
$GroupeEtudiants2025 = @()
Write-Host "   OK Groupe cree" -ForegroundColor Green

# 3. Ajouter tous les utilisateurs de "Promo2025" dans le groupe
Write-Host "`n3. Ajout des utilisateurs de 'Promo2025' dans 'Etudiants2025'..." -ForegroundColor Cyan
$Users | Where-Object {$_.OU -eq "Promo2025"} | ForEach-Object {
    $GroupeEtudiants2025 += $_
    Write-Host "   OK $($_.Prenom) $($_.Nom) ajoute(e)" -ForegroundColor Green
}

# 4. Exporter la liste finale du groupe en CSV
Write-Host "`n4. Export de la liste finale en CSV..." -ForegroundColor Cyan
$GroupeExport = $GroupeEtudiants2025 | ForEach-Object {
    [PSCustomObject]$_
}
$GroupeExport | Export-Csv -Path ".\Etudiants2025.csv" -NoTypeInformation -Encoding UTF8
Write-Host "   OK Fichier cree : Etudiants2025.csv" -ForegroundColor Green

# Resume final
Write-Host "`n========================================" -ForegroundColor Magenta
Write-Host "   RESUME" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "Nombre d'utilisateurs crees : $($Users.Count)" -ForegroundColor Yellow
Write-Host "Nombre de membres dans Etudiants2025 : $($GroupeEtudiants2025.Count)" -ForegroundColor Yellow
Write-Host "Fichier CSV genere : Etudiants2025.csv" -ForegroundColor Yellow
Write-Host "`nMini-projet termine avec succes!`n" -ForegroundColor Green