<#
.SYNOPSIS
    Script de laboratoire 4 - Gestion de l'arrêt et redémarrage des services AD
    
.DESCRIPTION
    Ce script permet de gérer l'arrêt et le redémarrage des services Active Directory
    avec des contrôles de sécurité et des confirmations.
    
.NOTES
    Lab: #300150205
    Fichier: services4.ps1
    Auteur: Laboratoire AD
    Date: Novembre 2025
    
.WARNING
    L'arrêt de services critiques peut affecter le fonctionnement du domaine.
    Utilisez ce script uniquement pendant une fenêtre de maintenance.
#>

# Vérification des privilèges administrateur
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
    Write-Host "⚠ ERREUR : Ce script nécessite des privilèges administrateur" -ForegroundColor Red
    Write-Host "Faites un clic droit sur PowerShell et sélectionnez 'Exécuter en tant qu'administrateur'" -ForegroundColor Yellow
    Read-Host "Appuyez sur Entrée pour quitter"
    exit
}

# Bannière
Clear-Host
Write-Host "════════════════════════════════════════════════════" -ForegroundColor Red
Write-Host "  LAB 4 - GESTION DES SERVICES AD" -ForegroundColor Red
Write-Host "  Lab #300150205" -ForegroundColor Gray
Write-Host "════════════════════════════════════════════════════" -ForegroundColor Red
Write-Host ""
Write-Host "⚠  AVERTISSEMENT : " -ForegroundColor Yellow -NoNewline
Write-Host "Impact sur le domaine possible" -ForegroundColor Red
Write-Host ""

# Configuration des services
$Services = @{
    "ADWS" = @{
        Name = "ADWS"
        DisplayName = "Active Directory Web Services"
        Critical = $false
        Impact = "Faible - Affecte uniquement PowerShell AD cmdlets"
        SafeToRestart = $true
    }
    "W32Time" = @{
        Name = "W32Time"
        DisplayName = "Service de Temps Windows"
        Critical = $false
        Impact = "Moyen - Peut affecter la synchronisation temps"
        SafeToRestart = $true
    }
    "DNS" = @{
        Name = "DNS"
        DisplayName = "Serveur DNS"
        Critical = $true
        Impact = "Élevé - Résolution de noms temporairement indisponible"
        SafeToRestart = $true
    }
    "NTDS" = @{
        Name = "NTDS"
        DisplayName = "Active Directory Domain Services"
        Critical = $true
        Impact = "CRITIQUE - Domaine complètement inaccessible"
        SafeToRestart = $false
    }
    "Netlogon" = @{
        Name = "Netlogon"
        DisplayName = "Netlogon"
        Critical = $true
        Impact = "CRITIQUE - Authentification impossible"
        SafeToRestart = $false
    }
    "KDC" = @{
        Name = "KDC"
        DisplayName = "Centre de distribution de clés Kerberos"
        Critical = $true
        Impact = "CRITIQUE - Authentification Kerberos impossible"
        SafeToRestart = $false
    }
}

# Fonction pour afficher les informations d'un service
function Show-ServiceInfo {
    param([hashtable]$ServiceInfo)
    
    $Service = Get-Service $ServiceInfo.Name -ErrorAction SilentlyContinue
    
    if ($Service) {
        Write-Host "Service     : " -NoNewline -ForegroundColor Cyan
        Write-Host "$($ServiceInfo.DisplayName)"
        
        Write-Host "Statut      : " -NoNewline -ForegroundColor Cyan
        if ($Service.Status -eq "Running") {
            Write-Host "$($Service.Status)" -ForegroundColor Green
        } else {
            Write-Host "$($Service.Status)" -ForegroundColor Red
        }
        
        Write-Host "Critique    : " -NoNewline -ForegroundColor Cyan
        if ($ServiceInfo.Critical) {
            Write-Host "OUI" -ForegroundColor Red
        } else {
            Write-Host "NON" -ForegroundColor Yellow
        }
        
        Write-Host "Impact      : " -NoNewline -ForegroundColor Cyan
        Write-Host "$($ServiceInfo.Impact)" -ForegroundColor Yellow
        
        Write-Host "Redémarrage : " -NoNewline -ForegroundColor Cyan
        if ($ServiceInfo.SafeToRestart) {
            Write-Host "Autorisé" -ForegroundColor Green
        } else {
            Write-Host "NON RECOMMANDÉ" -ForegroundColor Red
        }
    } else {
        Write-Host "⚠ Service non installé ou non accessible" -ForegroundColor Yellow
    }
}

# Fonction pour arrêter un service
function Stop-ADService {
    param(
        [string]$ServiceName,
        [hashtable]$ServiceInfo
    )
    
    Write-Host ""
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Yellow
    Write-Host "  ARRÊT DU SERVICE" -ForegroundColor Yellow
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Yellow
    Write-Host ""
    
    Show-ServiceInfo -ServiceInfo $ServiceInfo
    
    Write-Host ""
    if ($ServiceInfo.Critical -and -not $ServiceInfo.SafeToRestart) {
        Write-Host "⛔ ATTENTION : Service CRITIQUE" -ForegroundColor Red
        Write-Host "L'arrêt de ce service peut rendre le domaine inaccessible !" -ForegroundColor Red
        Write-Host ""
        $Confirm1 = Read-Host "Êtes-vous ABSOLUMENT certain de vouloir continuer ? (OUI/NON)"
        
        if ($Confirm1 -ne "OUI") {
            Write-Host "✓ Opération annulée (décision sage)" -ForegroundColor Green
            return
        }
        
        Write-Host ""
        Write-Host "⚠ DERNIÈRE CONFIRMATION" -ForegroundColor Red
        $Confirm2 = Read-Host "Tapez le nom du service '$ServiceName' pour confirmer"
        
        if ($Confirm2 -ne $ServiceName) {
            Write-Host "✓ Opération annulée" -ForegroundColor Green
            return
        }
    } else {
        $Confirm = Read-Host "Confirmer l'arrêt ? (O/N)"
        if ($Confirm -ne "O") {
            Write-Host "✓ Opération annulée" -ForegroundColor Green
            return
        }
    }
    
    Write-Host ""
    Write-Host "→ Arrêt du service $ServiceName en cours..." -ForegroundColor Yellow
    
    try {
        Stop-Service -Name $ServiceName -Force -ErrorAction Stop
        Start-Sleep -Seconds 2
        
        $Service = Get-Service $ServiceName
        if ($Service.Status -eq "Stopped") {
            Write-Host "✓ Service arrêté avec succès" -ForegroundColor Green
            
            # Log l'événement
            Write-EventLog -LogName Application -Source "PowerShell" -EventId 1000 -EntryType Information `
                -Message "Service $ServiceName arrêté via services4.ps1 (Lab #300150205)" -ErrorAction SilentlyContinue
        } else {
            Write-Host "⚠ Le service n'est pas complètement arrêté : $($Service.Status)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "✗ Erreur lors de l'arrêt du service" -ForegroundColor Red
        Write-Host "  $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Fonction pour démarrer un service
function Start-ADService {
    param(
        [string]$ServiceName,
        [hashtable]$ServiceInfo
    )
    
    Write-Host ""
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Green
    Write-Host "  DÉMARRAGE DU SERVICE" -ForegroundColor Green
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Green
    Write-Host ""
    
    $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
    
    if (-not $Service) {
        Write-Host "✗ Service $ServiceName non trouvé" -ForegroundColor Red
        return
    }
    
    if ($Service.Status -eq "Running") {
        Write-Host "⚠ Le service est déjà en cours d'exécution" -ForegroundColor Yellow
        Show-ServiceInfo -ServiceInfo $ServiceInfo
        return
    }
    
    Write-Host "→ Démarrage du service $ServiceName..." -ForegroundColor Yellow
    
    try {
        Start-Service -Name $ServiceName -ErrorAction Stop
        Start-Sleep -Seconds 3
        
        $Service = Get-Service $ServiceName
        if ($Service.Status -eq "Running") {
            Write-Host "✓ Service démarré avec succès" -ForegroundColor Green
            Write-Host ""
            Show-ServiceInfo -ServiceInfo $ServiceInfo
            
            # Log l'événement
            Write-EventLog -LogName Application -Source "PowerShell" -EventId 1001 -EntryType Information `
                -Message "Service $ServiceName démarré via services4.ps1 (Lab #300150205)" -ErrorAction SilentlyContinue
        } else {
            Write-Host "⚠ Le service n'a pas démarré correctement : $($Service.Status)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "✗ Erreur lors du démarrage du service" -ForegroundColor Red
        Write-Host "  $($_.Exception.Message)" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Vérifiez les journaux d'événements pour plus de détails" -ForegroundColor Yellow
    }
}

# Fonction pour redémarrer un service
function Restart-ADService {
    param(
        [string]$ServiceName,
        [hashtable]$ServiceInfo
    )
    
    Write-Host ""
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  REDÉMARRAGE DU SERVICE" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
    
    Show-ServiceInfo -ServiceInfo $ServiceInfo
    
    Write-Host ""
    if (-not $ServiceInfo.SafeToRestart) {
        Write-Host "⚠ ATTENTION : Ce service n'est pas recommandé pour redémarrage" -ForegroundColor Red
        $Confirm = Read-Host "Continuer quand même ? (OUI/NON)"
        if ($Confirm -ne "OUI") {
            Write-Host "✓ Opération annulée" -ForegroundColor Green
            return
        }
    } else {
        $Confirm = Read-Host "Confirmer le redémarrage ? (O/N)"
        if ($Confirm -ne "O") {
            Write-Host "✓ Opération annulée" -ForegroundColor Green
            return
        }
    }
    
    Write-Host ""
    Write-Host "→ Phase 1/2 : Arrêt du service..." -ForegroundColor Yellow
    
    try {
        Stop-Service -Name $ServiceName -Force -ErrorAction Stop
        Start-Sleep -Seconds 2
        Write-Host "  ✓ Service arrêté" -ForegroundColor Green
        
        Write-Host "→ Phase 2/2 : Démarrage du service..." -ForegroundColor Yellow
        Start-Sleep -Seconds 1
        
        Start-Service -Name $ServiceName -ErrorAction Stop
        Start-Sleep -Seconds 3
        
        $Service = Get-Service $ServiceName
        if ($Service.Status -eq "Running") {
            Write-Host "  ✓ Service démarré" -ForegroundColor Green
            Write-Host ""
            Write-Host "✓ Redémarrage terminé avec succès" -ForegroundColor Green
            
            # Log l'événement
            Write-EventLog -LogName Application -Source "PowerShell" -EventId 1002 -EntryType Information `
                -Message "Service $ServiceName redémarré via services4.ps1 (Lab #300150205)" -ErrorAction SilentlyContinue
        } else {
            Write-Host "  ⚠ Statut actuel : $($Service.Status)" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "✗ Erreur lors du redémarrage" -ForegroundColor Red
        Write-Host "  $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Menu principal
function Show-MainMenu {
    Write-Host ""
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  MENU PRINCIPAL" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [1] Afficher l'état des services" -ForegroundColor White
    Write-Host "  [2] Arrêter un service" -ForegroundColor Yellow
    Write-Host "  [3] Démarrer un service" -ForegroundColor Green
    Write-Host "  [4] Redémarrer un service" -ForegroundColor Cyan
    Write-Host "  [5] Surveillance en temps réel" -ForegroundColor Magenta
    Write-Host "  [6] Rapport complet" -ForegroundColor White
    Write-Host "  [0] Quitter" -ForegroundColor Gray
    Write-Host ""
}

# Surveillance en temps réel
function Start-ServiceMonitoring {
    Write-Host ""
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Magenta
    Write-Host "  SURVEILLANCE EN TEMPS RÉEL" -ForegroundColor Magenta
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "Appuyez sur Ctrl+C pour arrêter la surveillance" -ForegroundColor Yellow
    Write-Host ""
    Start-Sleep -Seconds 2
    
    $Counter = 0
    
    try {
        while ($true) {
            Clear-Host
            Write-Host "═══════════════════════════════════════════" -ForegroundColor Magenta
            Write-Host "  SURVEILLANCE DES SERVICES AD" -ForegroundColor Magenta
            Write-Host "═══════════════════════════════════════════" -ForegroundColor Magenta
            Write-Host "Actualisation : $(Get-Date -Format 'HH:mm:ss') | " -NoNewline -ForegroundColor Gray
            Write-Host "Cycle #$Counter" -ForegroundColor Gray
            Write-Host ""
            
            foreach ($Key in $Services.Keys) {
                $ServiceInfo = $Services[$Key]
                $Service = Get-Service $ServiceInfo.Name -ErrorAction SilentlyContinue
                
                if ($Service) {
                    $StatusColor = if ($Service.Status -eq "Running") { "Green" } else { "Red" }
                    $Icon = if ($Service.Status -eq "Running") { "✓" } else { "✗" }
                    
                    Write-Host "$Icon " -ForegroundColor $StatusColor -NoNewline
                    Write-Host "$($ServiceInfo.DisplayName.PadRight(40))" -NoNewline
                    Write-Host " [$($Service.Status)]" -ForegroundColor $StatusColor
                }
            }
            
            Write-Host ""
            Write-Host "Appuyez sur Ctrl+C pour quitter..." -ForegroundColor Gray
            
            Start-Sleep -Seconds 5
            $Counter++
        }
    }
    catch {
        Write-Host ""
        Write-Host "Surveillance arrêtée" -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    }
}

# Boucle principale
do {
    Show-MainMenu
    $Choice = Read-Host "Votre choix"
    
    switch ($Choice) {
        "1" {
            Write-Host ""
            Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
            Write-Host "  ÉTAT DES SERVICES" -ForegroundColor Cyan
            Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
            Write-Host ""
            
            foreach ($Key in $Services.Keys) {
                Write-Host "──────────────────────────────────────────" -ForegroundColor Gray
                Show-ServiceInfo -ServiceInfo $Services[$Key]
                Write-Host ""
            }
        }
        
        "2" {
            Write-Host ""
            Write-Host "Services disponibles :" -ForegroundColor Yellow
            $i = 1
            $ServiceList = @()
            foreach ($Key in $Services.Keys) {
                Write-Host "  [$i] $($Services[$Key].DisplayName)" -ForegroundColor White
                $ServiceList += $Key
                $i++
            }
            Write-Host ""
            
            $Selection = Read-Host "Sélectionnez un service (1-$($Services.Count))"
            $Index = [int]$Selection - 1
            
            if ($Index -ge 0 -and $Index -lt $Services.Count) {
                $SelectedKey = $ServiceList[$Index]
                Stop-ADService -ServiceName $SelectedKey -ServiceInfo $Services[$SelectedKey]
            } else {
                Write-Host "⚠ Sélection invalide" -ForegroundColor Yellow
            }
        }
        
        "3" {
            Write-Host ""
            Write-Host "Services disponibles :" -ForegroundColor Yellow
            $i = 1
            $ServiceList = @()
            foreach ($Key in $Services.Keys) {
                Write-Host "  [$i] $($Services[$Key].DisplayName)" -ForegroundColor White
                $ServiceList += $Key
                $i++
            }
            Write-Host ""
            
            $Selection = Read-Host "Sélectionnez un service (1-$($Services.Count))"
            $Index = [int]$Selection - 1
            
            if ($Index -ge 0 -and $Index -lt $Services.Count) {
                $SelectedKey = $ServiceList[$Index]
                Start-ADService -ServiceName $SelectedKey -ServiceInfo $Services[$SelectedKey]
            } else {
                Write-Host "⚠ Sélection invalide" -ForegroundColor Yellow
            }
        }
        
        "4" {
            Write-Host ""
            Write-Host "Services disponibles pour redémarrage :" -ForegroundColor Yellow
            $i = 1
            $ServiceList = @()
            foreach ($Key in $Services.Keys) {
                $Safe = if ($Services[$Key].SafeToRestart) { "✓" } else { "⚠" }
                Write-Host "  [$i] $Safe $($Services[$Key].DisplayName)" -ForegroundColor White
                $ServiceList += $Key
                $i++
            }
            Write-Host ""
            
            $Selection = Read-Host "Sélectionnez un service (1-$($Services.Count))"
            $Index = [int]$Selection - 1
            
            if ($Index -ge 0 -and $Index -lt $Services.Count) {
                $SelectedKey = $ServiceList[$Index]
                Restart-ADService -ServiceName $SelectedKey -ServiceInfo $Services[$SelectedKey]
            } else {
                Write-Host "⚠ Sélection invalide" -ForegroundColor Yellow
            }
        }
        
        "5" {
            Start-ServiceMonitoring
        }
        
        "6" {
            Write-Host ""
            Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
            Write-Host "  RAPPORT COMPLET" -ForegroundColor Cyan
            Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Serveur     : $(hostname)" -ForegroundColor White
            Write-Host "Date/Heure  : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor White
            Write-Host "Utilisateur : $env:USERNAME" -ForegroundColor White
            Write-Host ""
            
            $RunningCount = 0
            $StoppedCount = 0
            
            foreach ($Key in $Services.Keys) {
                $Service = Get-Service $Services[$Key].Name -ErrorAction SilentlyContinue
                if ($Service) {
                    if ($Service.Status -eq "Running") { $RunningCount++ }
                    else { $StoppedCount++ }
                }
            }
            
            Write-Host "Services surveillés : $($Services.Count)" -ForegroundColor Cyan
            Write-Host "En cours d'exécution: " -NoNewline
            Write-Host "$RunningCount" -ForegroundColor Green
            Write-Host "Arrêtés             : " -NoNewline
            if ($StoppedCount -gt 0) {
                Write-Host "$StoppedCount" -ForegroundColor Red
            } else {
                Write-Host "$StoppedCount" -ForegroundColor Green
            }
            
            Write-Host ""
            foreach ($Key in $Services.Keys) {
                Write-Host "──────────────────────────────────────────" -ForegroundColor Gray
                Show-ServiceInfo -ServiceInfo $Services[$Key]
                Write-Host ""
            }
        }
        
        "0" {
            Write-Host ""
            Write-Host "Fermeture du laboratoire 4..." -ForegroundColor Gray
        }
        
        default {
            Write-Host ""
            Write-Host "⚠ Option invalide" -ForegroundColor Yellow
        }
    }
    
    if ($Choice -ne "0" -and $Choice -ne "5") {
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer"
    }
    
} while ($Choice -ne "0")

Write-Host ""
Write-Host "════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  LABORATOIRE 4 TERMINÉ" -ForegroundColor Cyan
Write-Host "  Lab #300150205" -ForegroundColor Gray
Write-Host "════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "✓ Tous les laboratoires sont maintenant complétés !" -ForegroundColor Green
Write-Host ""
