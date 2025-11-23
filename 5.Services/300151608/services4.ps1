
# TP 5.Services - Étudiant : 300151608
# Script 4 — Vérification ciblée de l’état des services AD

Write-Host "==== Vérification rapide des services AD ====" -ForegroundColor Cyan

# 1️⃣ Fonction pour afficher l’état proprement
function Check-ServiceStatus {
    param([string]$svcName)

    $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
    if ($svc) {
        Write-Host "$svcName → $($svc.Status)" -ForegroundColor Green
    } else {
        Write-Host "Service $svcName introuvable" -ForegroundColor Red
    }
}

# 2️⃣ Vérifier les services importants
Check-ServiceStatus -svcName "DFSR"
Check-ServiceStatus -svcName "NTDS"
Check-ServiceStatus -svcName "ADWS"

Write-Host "`n==== Tableau détaillé ====" -ForegroundColor Yellow

# 3️⃣ Vue détaillée
Get-Service -Name DFSR, NTDS, ADWS |
Select-Object Status, Name, DisplayName
