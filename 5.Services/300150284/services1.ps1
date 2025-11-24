<#
.SYNOPSIS
    Script de laboratoire 1 - Liste et vérification des services Active Directory
    
.DESCRIPTION
    Ce script affiche l'état de tous les services Active Directory critiques
    et génère un rapport de santé complet.
    
.NOTES
    Lab: #300150205
    Fichier: services1.ps1
    Auteur: Laboratoire AD
    Date: Novembre 2025
#>

# Bannière
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  LAB 1 - LISTE DES SERVICES AD" -ForegroundColor Cyan
Write-Host "  Lab #300150205" -ForegroundColor Gray
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# Liste des services critiques Active Directory
$ADServices = @("NTDS", "DNS", "KDC", "Netlogon", "W32Time", "ADWS", "DFS", "DFSR")

Write-Host "[1] Services Active Directory détectés :" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray
Get-Service | Where-Object {$_.DisplayName -like "*Active Directory*"} | 
    Format-Table Name, Status, StartType, DisplayName -AutoSize

Write-Host ""
Write-Host "[2] État des services critiques AD :" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray

# Compteurs
$RunningCount = 0
$StoppedCount = 0

foreach ($ServiceName in $ADServices) {
    $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
    
    if ($Service) {
        $Status = $Service.Status
        $StartType = $Service.StartType
        
        # Couleur selon le statut
        if ($Status -eq "Running") {
            $Color = "Green"
            $Icon = "✓"
            $RunningCount++
        } else {
            $Color = "Red"
            $Icon = "✗"
            $StoppedCount++
        }
        
        Write-Host "$Icon " -ForegroundColor $Color -NoNewline
        Write-Host "$($Service.DisplayName.PadRight(45))" -NoNewline
        Write-Host " [$Status]" -ForegroundColor $Color -NoNewline
        Write-Host " ($StartType)" -ForegroundColor Gray
    } else {
        Write-Host "⚠ " -ForegroundColor Yellow -NoNewline
        Write-Host "$ServiceName".PadRight(45) -NoNewline
        Write-Host " [Non installé]" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "[3] Résumé :" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray
Write-Host "Services en cours d'exécution : " -NoNewline
Write-Host "$RunningCount" -ForegroundColor Green

Write-Host "Services arrêtés              : " -NoNewline
if ($StoppedCount -gt 0) {
    Write-Host "$StoppedCount" -ForegroundColor Red
} else {
    Write-Host "$StoppedCount" -ForegroundColor Green
}

Write-Host ""
Write-Host "[4] Services AD détaillés :" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray

Get-Service $ADServices -ErrorAction SilentlyContinue | 
    Format-Table Name, Status, StartType, DisplayName -AutoSize

# Vérification des services arrêtés
Write-Host ""
$StoppedServices = Get-Service $ADServices -ErrorAction SilentlyContinue | 
    Where-Object {$_.Status -ne "Running"}

if ($StoppedServices) {
    Write-Host "⚠ ATTENTION : Services non opérationnels détectés !" -ForegroundColor Red
    Write-Host ""
    $StoppedServices | Format-Table Name, Status, DisplayName -AutoSize
    
    Write-Host "Action recommandée : Vérifier les journaux avec services2.ps1" -ForegroundColor Yellow
} else {
    Write-Host "✓ Tous les services AD sont opérationnels !" -ForegroundColor Green
}

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  Laboratoire 1 terminé" -ForegroundColor Cyan
Write-Host "  Passez au Lab 2 : .\services2.ps1" -ForegroundColor Gray
Write-Host "=============================================" -ForegroundColor Cyan
