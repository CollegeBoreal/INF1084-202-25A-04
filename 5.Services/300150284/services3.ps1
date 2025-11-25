<#
.SYNOPSIS
    Script de laboratoire 3 - Exportation des journaux d'événements AD
    
.DESCRIPTION
    Ce script exporte les journaux Active Directory vers des fichiers
    pour archivage et analyse approfondie.
    
.NOTES
    Lab: #300150205
    Fichier: services3.ps1
    Auteur: Laboratoire AD
    Date: Novembre 2025
#>

# Bannière
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  LAB 3 - EXPORT DES JOURNAUX AD" -ForegroundColor Cyan
Write-Host "  Lab #300150205" -ForegroundColor Gray
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# Configuration des chemins
$ExportBasePath = "C:\ADLogs"
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$ExportFolder = "$ExportBasePath\Export_$Timestamp"

# Vérifier/Créer le dossier d'export
if (-not (Test-Path $ExportBasePath)) {
    Write-Host "[Création du dossier] $ExportBasePath" -ForegroundColor Yellow
    New-Item -Path $ExportBasePath -ItemType Directory -Force | Out-Null
    Write-Host "✓ Dossier créé avec succès" -ForegroundColor Green
    Write-Host ""
}

Write-Host "[Dossier d'export] $ExportFolder" -ForegroundColor Cyan
New-Item -Path $ExportFolder -ItemType Directory -Force | Out-Null
Write-Host ""

# Menu d'export
function Show-ExportMenu {
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  OPTIONS D'EXPORT" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [1] Export complet (tous les journaux)" -ForegroundColor White
    Write-Host "  [2] Export Directory Service uniquement" -ForegroundColor White
    Write-Host "  [3] Export DNS Server uniquement" -ForegroundColor White
    Write-Host "  [4] Export erreurs uniquement (CSV)" -ForegroundColor White
    Write-Host "  [5] Export personnalisé (choix du nombre d'événements)" -ForegroundColor White
    Write-Host "  [6] Export au format texte lisible" -ForegroundColor White
    Write-Host "  [7] Export des événements critiques" -ForegroundColor White
    Write-Host "  [0] Quitter" -ForegroundColor Gray
    Write-Host ""
}

# Fonction d'export avec barre de progression
function Export-EventLogWithProgress {
    param(
        [string]$LogName,
        [int]$NumberOfEvents,
        [string]$OutputPath,
        [string]$Format = "CSV"
    )
    
    try {
        Write-Host "  → Récupération de $NumberOfEvents événements de [$LogName]..." -ForegroundColor Yellow
        $Events = Get-EventLog -LogName $LogName -Newest $NumberOfEvents -ErrorAction Stop
        
        if ($Format -eq "CSV") {
            $Events | Select-Object TimeGenerated, EntryType, Source, EventID, 
                @{Name="Message";Expression={$_.Message -replace "`r`n", " "}} |
                Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
        }
        elseif ($Format -eq "TXT") {
            $Events | Format-List TimeGenerated, EntryType, Source, EventID, Message |
                Out-File -FilePath $OutputPath -Encoding UTF8
        }
        
        $FileSize = (Get-Item $OutputPath).Length / 1KB
        Write-Host "  ✓ Export réussi : $([Math]::Round($FileSize, 2)) KB" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "  ✗ Erreur lors de l'export de [$LogName]" -ForegroundColor Red
        Write-Host "    $($_.Exception.Message)" -ForegroundColor Yellow
        return $false
    }
}

# Fonction pour afficher un résumé
function Show-ExportSummary {
    param([string]$FolderPath)
    
    Write-Host ""
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  RÉSUMÉ DE L'EXPORT" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
    
    $Files = Get-ChildItem -Path $FolderPath -File
    $TotalSize = ($Files | Measure-Object -Property Length -Sum).Sum / 1KB
    
    Write-Host "📁 Emplacement : $FolderPath" -ForegroundColor White
    Write-Host "📊 Nombre de fichiers : $($Files.Count)" -ForegroundColor White
    Write-Host "💾 Taille totale : $([Math]::Round($TotalSize, 2)) KB" -ForegroundColor White
    Write-Host ""
    
    Write-Host "Fichiers créés :" -ForegroundColor Yellow
    foreach ($File in $Files) {
        $Size = [Math]::Round($File.Length / 1KB, 2)
        Write-Host "  • $($File.Name) ($Size KB)" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "✓ Export terminé avec succès !" -ForegroundColor Green
}

# Boucle principale
do {
    Show-ExportMenu
    $Choice = Read-Host "Votre choix"
    Write-Host ""
    
    switch ($Choice) {
        "1" {
            Write-Host "[EXPORT COMPLET] Tous les journaux AD" -ForegroundColor Cyan
            Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray
            Write-Host ""
            
            $Logs = @{
                "Directory Service" = "DirectoryService"
                "DNS Server" = "DNSServer"
                "System" = "System"
            }
            
            $SuccessCount = 0
            
            foreach ($LogName in $Logs.Keys) {
                $FileName = "$ExportFolder\$($Logs[$LogName])_$Timestamp.csv"
                if (Export-EventLogWithProgress -LogName $LogName -NumberOfEvents 1000 -OutputPath $FileName) {
                    $SuccessCount++
                }
            }
            
            Write-Host ""
            Write-Host "Export terminé : $SuccessCount/$($Logs.Count) journaux exportés" -ForegroundColor Cyan
            Show-ExportSummary -FolderPath $ExportFolder
        }
        
        "2" {
            Write-Host "[EXPORT] Directory Service uniquement" -ForegroundColor Cyan
            Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray
            Write-Host ""
            
            $FileName = "$ExportFolder\DirectoryService_$Timestamp.csv"
            Export-EventLogWithProgress -LogName "Directory Service" -NumberOfEvents 1000 -OutputPath $FileName
            
            Write-Host ""
            Write-Host "✓ Fichier créé : $FileName" -ForegroundColor Green
        }
        
        "3" {
            Write-Host "[EXPORT] DNS Server uniquement" -ForegroundColor Cyan
            Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray
            Write-Host ""
            
            $FileName = "$ExportFolder\DNSServer_$Timestamp.csv"
            Export-EventLogWithProgress -LogName "DNS Server" -NumberOfEvents 1000 -OutputPath $FileName
            
            Write-Host ""
            Write-Host "✓ Fichier créé : $FileName" -ForegroundColor Green
        }
        
        "4" {
            Write-Host "[EXPORT] Erreurs uniquement" -ForegroundColor Red
            Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray
            Write-Host ""
            
            $ErrorFile = "$ExportFolder\AD_Errors_$Timestamp.csv"
            
            try {
                Write-Host "  → Récupération des erreurs..." -ForegroundColor Yellow
                
                $AllErrors = @()
                
                # Directory Service Errors
                $DSErrors = Get-EventLog -LogName "Directory Service" -EntryType Error -Newest 500 -ErrorAction SilentlyContinue
                if ($DSErrors) {
                    $AllErrors += $DSErrors | Select-Object @{Name="Journal";Expression={"Directory Service"}}, 
                        TimeGenerated, EntryType, EventID, Source, 
                        @{Name="Message";Expression={$_.Message -replace "`r`n", " "}}
                }
                
                # DNS Errors
                $DNSErrors = Get-EventLog -LogName "DNS Server" -EntryType Error -Newest 500 -ErrorAction SilentlyContinue
                if ($DNSErrors) {
                    $AllErrors += $DNSErrors | Select-Object @{Name="Journal";Expression={"DNS Server"}}, 
                        TimeGenerated, EntryType, EventID, Source, 
                        @{Name="Message";Expression={$_.Message -replace "`r`n", " "}}
                }
                
                # System Errors (AD related)
                $SysErrors = Get-EventLog -LogName System -EntryType Error -Newest 500 -ErrorAction SilentlyContinue |
                    Where-Object {$_.Message -like "*NTDS*" -or $_.Message -like "*DNS*"}
                if ($SysErrors) {
                    $AllErrors += $SysErrors | Select-Object @{Name="Journal";Expression={"System"}}, 
                        TimeGenerated, EntryType, EventID, Source, 
                        @{Name="Message";Expression={$_.Message -replace "`r`n", " "}}
                }
                
                $AllErrors | Export-Csv -Path $ErrorFile -NoTypeInformation -Encoding UTF8
                
                $FileSize = (Get-Item $ErrorFile).Length / 1KB
                Write-Host "  ✓ $($AllErrors.Count) erreurs exportées ($([Math]::Round($FileSize, 2)) KB)" -ForegroundColor Green
                Write-Host ""
                Write-Host "✓ Fichier créé : $ErrorFile" -ForegroundColor Green
            }
            catch {
                Write-Host "  ✗ Erreur lors de l'export" -ForegroundColor Red
            }
        }
        
        "5" {
            Write-Host "[EXPORT PERSONNALISÉ]" -ForegroundColor Cyan
            Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray
            Write-Host ""
            
            $NumEvents = Read-Host "Nombre d'événements à exporter (ex: 500)"
            
            Write-Host ""
            Write-Host "Journaux disponibles :" -ForegroundColor Yellow
            Write-Host "  1. Directory Service"
            Write-Host "  2. DNS Server"
            Write-Host "  3. System"
            $LogChoice = Read-Host "Sélectionnez le journal (1-3)"
            
            $LogName = switch ($LogChoice) {
                "1" { "Directory Service"; "DirectoryService" }
                "2" { "DNS Server"; "DNSServer" }
                "3" { "System"; "System" }
                default { "Directory Service"; "DirectoryService" }
            }
            
            Write-Host ""
            $FileName = "$ExportFolder\$($LogName[1])_Custom_$Timestamp.csv"
            Export-EventLogWithProgress -LogName $LogName[0] -NumberOfEvents $NumEvents -OutputPath $FileName
            
            Write-Host ""
            Write-Host "✓ Fichier créé : $FileName" -ForegroundColor Green
        }
        
        "6" {
            Write-Host "[EXPORT TEXTE] Format lisible" -ForegroundColor Cyan
            Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray
            Write-Host ""
            
            $TextFile = "$ExportFolder\AD_Events_Readable_$Timestamp.txt"
            
            try {
                Write-Host "  → Création du fichier texte..." -ForegroundColor Yellow
                
                "═══════════════════════════════════════════════════════════" | Out-File $TextFile
                "  EXPORT DES JOURNAUX ACTIVE DIRECTORY" | Out-File $TextFile -Append
                "  Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File $TextFile -Append
                "  Lab: #300150205" | Out-File $TextFile -Append
                "═══════════════════════════════════════════════════════════" | Out-File $TextFile -Append
                "" | Out-File $TextFile -Append
                
                # Directory Service
                "───────────────────────────────────────────────────────────" | Out-File $TextFile -Append
                "[DIRECTORY SERVICE] - 100 derniers événements" | Out-File $TextFile -Append
                "───────────────────────────────────────────────────────────" | Out-File $TextFile -Append
                Get-EventLog -LogName "Directory Service" -Newest 100 -ErrorAction SilentlyContinue |
                    Format-List TimeGenerated, EntryType, EventID, Source, Message | Out-File $TextFile -Append
                
                $FileSize = (Get-Item $TextFile).Length / 1KB
                Write-Host "  ✓ Export réussi : $([Math]::Round($FileSize, 2)) KB" -ForegroundColor Green
                Write-Host ""
                Write-Host "✓ Fichier créé : $TextFile" -ForegroundColor Green
            }
            catch {
                Write-Host "  ✗ Erreur lors de l'export" -ForegroundColor Red
            }
        }
        
        "7" {
            Write-Host "[EXPORT] Événements critiques" -ForegroundColor Red
            Write-Host "─────────────────────────────────────────────" -ForegroundColor Gray
            Write-Host ""
            
            $CriticalFile = "$ExportFolder\AD_Critical_Events_$Timestamp.csv"
            
            # EventIDs critiques
            $CriticalEventIDs = @(1168, 2087, 1644, 1000, 1001)
            
            try {
                Write-Host "  → Recherche des événements critiques..." -ForegroundColor Yellow
                
                $CriticalEvents = Get-EventLog -LogName "Directory Service" -Newest 2000 -ErrorAction SilentlyContinue |
                    Where-Object {$CriticalEventIDs -contains $_.EventID} |
                    Select-Object TimeGenerated, EntryType, EventID, Source,
                        @{Name="Message";Expression={$_.Message -replace "`r`n", " "}}
                
                if ($CriticalEvents) {
                    $CriticalEvents | Export-Csv -Path $CriticalFile -NoTypeInformation -Encoding UTF8
                    Write-Host "  ✓ $($CriticalEvents.Count) événements critiques exportés" -ForegroundColor Green
                }
                else {
                    Write-Host "  ✓ Aucun événement critique trouvé" -ForegroundColor Green
                }
                
                Write-Host ""
                Write-Host "✓ Fichier créé : $CriticalFile" -ForegroundColor Green
            }
            catch {
                Write-Host "  ✗ Erreur lors de l'export" -ForegroundColor Red
            }
        }
        
        "0" {
            Write-Host "Fermeture du laboratoire 3..." -ForegroundColor Gray
        }
        
        default {
            Write-Host "⚠ Option invalide" -ForegroundColor Yellow
        }
    }
    
    if ($Choice -ne "0") {
        Write-Host ""
        Write-Host "Appuyez sur Entrée pour continuer..." -ForegroundColor Gray
        Read-Host
        Clear-Host
        Write-Host ""
    }
    
} while ($Choice -ne "0")

Write-Host ""
Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Laboratoire 3 terminé" -ForegroundColor Cyan
Write-Host "  Passez au Lab 4 : .\services4.ps1" -ForegroundColor Gray
Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "📁 Tous vos exports sont dans : $ExportBasePath" -ForegroundColor Yellow
