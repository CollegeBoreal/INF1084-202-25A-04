# TP 5.Services - Étudiant : 300151608
# Script 3 — Exportation des journaux AD dans un fichier CSV

Write-Host "==== Exportation des logs Active Directory ====" -ForegroundColor Cyan

# 1️⃣ Créer un dossier Logs s'il n'existe pas
$logPath = "C:\Logs"
if (!(Test-Path $logPath)) {
    New-Item -ItemType Directory -Path $logPath | Out-Null
    Write-Host "Dossier créé : $logPath"
}

# 2️⃣ Exporter 50 événements Directory Service
$csvFile = "$logPath\ADLogs.csv"

Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Select-Object TimeCreated, Id, LevelDisplayName, Message |
Export-Csv -Path $csvFile -NoTypeInformation

Write-Host "Logs exportés vers : $csvFile" -ForegroundColor Green

# 3️⃣ Vérifier le contenu du dossier
Write-Host "`nContenu du dossier Logs :" -ForegroundColor Yellow
Get-ChildItem $logPath

