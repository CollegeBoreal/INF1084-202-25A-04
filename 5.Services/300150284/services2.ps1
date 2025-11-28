<#
.SYNOPSIS
    Script de laboratoire 2 - Consultation des journaux d'événements AD
    
.DESCRIPTION
    Ce script affiche les événements des journaux Active Directory
    avec filtrage et analyse des erreurs critiques.
    
.NOTES
    Lab: #300150205
    Fichier: services2.ps1
    Auteur: Laboratoire AD
    Date: Novembre 2025
#>

# Bannière
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  LAB 2 - JOURNAUX D'ÉVÉNEMENTS AD" -ForegroundColor Cyan
Write-Host "  Lab #300150205" -ForegroundColor Gray
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# Menu interactif
function Show-Menu {
    Write-Host "Sélectionnez une option :" -ForegroundColor Yellow
    Write-Host "  [1] Événements Directory Service (AD DS)" -ForegroundColor White
    Write-Host "  [2] Événements DNS Server" -ForegroundColor White
    Write-Host "  [3] Événements System (Services)" -ForegroundColor White
    Write-Host "  [4] Erreurs uniquement (tous les journaux)" -ForegroundColor White
    Write-Host "  [5] Recherche par EventID" -ForegroundColor White
    Write-Host "  [6] Événements des dernières 24h" -ForegroundColor White
    Write-Host "  [7] Tous les événements critiques" -ForegroundColor White
    Write-Host "  [0] Quitter" -ForegroundColor Gray
    Write-Host ""
}

do {
    Show-Menu
    $Choice = Read-Host "Votre choix"
    Write-Host ""
    
    switch ($Choice) {
        "1" {
            Write-Host "[Directory Service] - 20 derniers événements" -ForegroundColor Cyan
            Write-Host "─────────────────────────────────────────────────────────" -ForegroundColor Gray
            
            try {
                $Events = Get-EventLog -LogName "Directory Service" -Newest 20 -ErrorAction Stop
                
                foreach ($Event in $Events) {
                    $Color = switch ($Event.EntryType) {
                        "Error" { "Red" }
                        "Warning" { "Yellow" }
                        "Information" { "Green" }
                        default { "White" }
                    }
                    
                    Write-Host "[$($Event.TimeGenerated)] " -NoNewline -ForegroundColor Gray
                    Write-Host "$($Event.EntryType) " -NoNewline -ForegroundColor $Color
                    Write-Host "ID:$($Event.EventID) - " -NoNewline -ForegroundColor Cyan
                    Write-Host "$($Event.Message.Substring(0, [Math]::Min(80, $Event.Message.Length)))..."
                }
                
                Write-Host ""
                Write-Host "Total : $($Events.Count) événements affichés" -ForegroundColor Green
            }
            catch {
                Write-Host "⚠ Erreur : Journal 'Directory Service' non accessible" -ForegroundColor Red
                Write-Host "Vérifiez que le rôle AD DS est installé." -ForegroundColor Yellow
            }
        }
        
        "2" {
            Write-Host "[DNS Server] - 20 derniers événements" -ForegroundColor Cyan
            Write-Host "─────────────────────────────────────────────────────────" -ForegroundColor Gray
            
            try {
                Get-EventLog -LogName "DNS Server" -Newest 20 -ErrorAction Stop | 
                    Format-Table TimeGenerated, EntryType, EventID, 
                        @{Label="Message";Expression={$_.Message.Substring(0, [Math]::Min(60, $_.Message.Length)) + "..."}} -AutoSize
            }
            catch {
                Write-Host "⚠ Erreur : Journal 'DNS Server' non accessible" -ForegroundColor Red
            }
        }
        
        "3" {
            Write-Host "[System] - Événements des services AD" -ForegroundColor Cyan
            Write-Host "─────────────────────────────────────────────────────────" -ForegroundColor Gray
            
            Get-EventLog -LogName System -Source "Service Control Manager" -Newest 30 | 
                Where-Object {$_.Message -like "*NTDS*" -or $_.Message -like "*DNS*" -or $_.Message -like "*Active Directory*"} |
                Format-Table TimeGenerated, EntryType, 
                    @{Label="Message";Expression={$_.Message.Substring(0, [Math]::Min(70, $_.Message.Length)) + "..."}} -AutoSize
        }
        
        "4" {
            Write-Host "[Erreurs] - Toutes les erreurs AD récentes" -ForegroundColor Red
            Write-Host "─────────────────────────────────────────────────────────" -ForegroundColor Gray
            
            $ErrorCount = 0
            
            # Directory Service Errors
            try {
                $DSErrors = Get-EventLog -LogName "Directory Service" -EntryType Error -Newest 10 -ErrorAction SilentlyContinue
                if ($DSErrors) {
                    Write-Host "`n[Directory Service - Erreurs]" -ForegroundColor Yellow
                    $DSErrors | Format-Table TimeGenerated, EventID, Message -Wrap
                    $ErrorCount += $DSErrors.Count
                }
            } catch {}
            
            # DNS Errors
            try {
                $DNSErrors = Get-EventLog -LogName "DNS Server" -EntryType Error -Newest 10 -ErrorAction SilentlyContinue
                if ($DNSErrors) {
                    Write-Host "`n[DNS Server - Erreurs]" -ForegroundColor Yellow
                    $DNSErrors | Format-Table TimeGenerated, EventID, Message -Wrap
                    $ErrorCount += $DNSErrors.Count
                }
            } catch {}
            
            if ($ErrorCount -eq 0) {
                Write-Host "✓ Aucune erreur récente détectée" -ForegroundColor Green
            } else {
                Write-Host "`n⚠ Total : $ErrorCount erreurs trouvées" -ForegroundColor Red
            }
        }
        
        "5" {
            $EventID = Read-Host "Entrez l'EventID à rechercher"
            
            Write-Host "`nRecherche de l'EventID $EventID..." -ForegroundColor Cyan
            Write-Host "─────────────────────────────────────────────────────────" -ForegroundColor Gray
            
            $Found = $false
            
            try {
                $DSEvents = Get-EventLog -LogName "Directory Service" -ErrorAction SilentlyContinue | 
                    Where-Object {$_.EventID -eq $EventID} | Select-Object -First 10
                
                if ($DSEvents) {
                    Write-Host "`n[Directory Service]" -ForegroundColor Yellow
                    $DSEvents | Format-List TimeGenerated, EntryType, EventID, Message
                    $Found = $true
                }
            } catch {}
            
            if (-not $Found) {
                Write-Host "Aucun événement trouvé avec l'ID $EventID" -ForegroundColor Yellow
            }
        }
        
        "6" {
            Write-Host "[24 dernières heures] - Tous les événements AD" -ForegroundColor Cyan
            Write-Host "─────────────────────────────────────────────────────────" -ForegroundColor Gray
            
            $Since = (Get-Date).AddHours(-24)
            
            try {
                $RecentEvents = Get-EventLog -LogName "Directory Service" -After $Since -ErrorAction SilentlyContinue
                
                Write-Host "Événements depuis : $Since" -ForegroundColor Gray
                Write-Host "Total trouvé : $($RecentEvents.Count) événements" -ForegroundColor Green
                Write-Host ""
                
                # Statistiques
                $Stats = $RecentEvents | Group-Object EntryType
                foreach ($Stat in $Stats) {
                    $Color = switch ($Stat.Name) {
                        "Error" { "Red" }
                        "Warning" { "Yellow" }
                        "Information" { "Green" }
                        default { "White" }
                    }
                    Write-Host "$($Stat.Name): $($Stat.Count)" -ForegroundColor $Color
                }
                
                Write-Host "`nDerniers événements :" -ForegroundColor Yellow
                $RecentEvents | Select-Object -First 20 | 
                    Format-Table TimeGenerated, EntryType, EventID, 
                        @{Label="Message";Expression={$_.Message.Substring(0, [Math]::Min(60, $_.Message.Length))}} -AutoSize
            }
            catch {
                Write-Host "⚠ Impossible de récupérer les événements" -ForegroundColor Red
            }
        }
        
        "7" {
            Write-Host "[Événements Critiques] - Analyse approfondie" -ForegroundColor Red
            Write-Host "─────────────────────────────────────────────────────────" -ForegroundColor Gray
            
            # EventIDs critiques à surveiller
            $CriticalEvents = @{
                1168 = "Erreur de réplication AD"
                2087 = "Échec de résolution DNS"
                1644 = "Recherches LDAP coûteuses"
                1000 = "Crash d'application"
                1001 = "Rapport d'erreur Windows"
            }
            
            Write-Host "Recherche des événements critiques..." -ForegroundColor Yellow
            Write-Host ""
            
            foreach ($EventID in $CriticalEvents.Keys) {
                try {
                    $Events = Get-EventLog -LogName "Directory Service" -ErrorAction SilentlyContinue | 
                        Where-Object {$_.EventID -eq $EventID} | Select-Object -First 5
                    
                    if ($Events) {
                        Write-Host "⚠ EventID $EventID : $($CriticalEvents[$EventID])" -ForegroundColor Red
                        Write-Host "  Occurrences : $($Events.Count)" -ForegroundColor Yellow
                        $Events | Format-Table TimeGenerated, EntryType -AutoSize
                    }
                }
                catch {}
            }
            
            Write-Host "Analyse terminée" -ForegroundColor Green
        }
        
        "0" {
            Write-Host "Fermeture du laboratoire 2..." -ForegroundColor Gray
        }
        
        default {
            Write-Host "⚠ Option invalide, veuillez réessayer" -ForegroundColor Yellow
        }
    }
    
    if ($Choice -ne "0") {
        Write-Host ""
        Write-Host "Appuyez sur Entrée pour continuer..." -ForegroundColor Gray
        Read-Host
        Write-Host ""
    }
    
} while ($Choice -ne "0")

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  Laboratoire 2 terminé" -ForegroundColor Cyan
Write-Host "  Passez au Lab 3 : .\services3.ps1" -ForegroundColor Gray
Write-Host "=============================================" -ForegroundColor Cyan
