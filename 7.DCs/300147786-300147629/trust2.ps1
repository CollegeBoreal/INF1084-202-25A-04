򠀍򠀍򠀍󐀢󐀊󐀊󐀊󐁮󐀊򠀍2ⵢʓʓWrite-Host "=== 1. Récupération des informations d'accès au domaine distant ===" -ForegroundColor Cyan

# Demande d'identifiants du domaine DC300147629-00.local
$credAD2 = Get-Credential -Message "Identifiants administrateur du domaine DC300147629-00.local requis"



Write-Host "=== 2. Test de disponibilité du contrôleur de domaine distant ===" -ForegroundColor Cyan

# Vérifie que le DC du domaine AD2 répond au ping
Test-Connection -ComputerName "DC300147629-00.local" -Count 2Write-Host "=== 1. Récupération des informations d'accès au domaine distant ===" -ForegroundColor Cyan

# Demande d'identifiants du domaine DC300147629-00.local
$credAD2 = Get-Credential -Message "Identifiants administrateur du domaine DC300147629-00.local requis"



Write-Host "=== 2. Test de disponibilité du contrôleur de domaine distant ===" -ForegroundColor Cyan

# Vérifie que le DC du domaine AD2 répond au ping
Test-Connection -ComputerName "DC300147629-00.local" -Count 2Write-Host "=== 1. Récupération des informations d'accès au domaine distant ===" -ForegroundColor Cyan

# Demande d'identifiants du domaine DC300147629-00.local
$credAD2 = Get-Credential -Message "Identifiants administrateur du domaine DC300147629-00.local requis"



Write-Host "=== 2. Test de disponibilité du contrôleur de domaine distant ===" -ForegroundCo
