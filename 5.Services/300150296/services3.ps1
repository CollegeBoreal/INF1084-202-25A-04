# TP Services AD - Étape 3 : Exporter les événements vers un fichier
# Étudiant : 300150296

Write-Host "=== Export des événements AD ===" -ForegroundColor Green

# Créer le dossier de logs s'il n'existe pas
$logPath = "C:\Logs"
if (-not (Test-Path $logPath)) {
    New-Item -Path $logPath -ItemType Directory
    Write-Host "Dossier créé : $logPath" -ForegroundColor Cyan
}

# Exporter les événements
$exportFile = "$logPath\ADLogs_300150296.csv"
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | 
Select-Object TimeCreated, Id, LevelDisplayName, Message |
Export-Csv -Path $exportFile -NoTypeInformation -Encoding UTF8

Write-Host "Export terminé : $exportFile" -ForegroundColor Green

# Afficher un aperçu
Write-Host "`n=== Aperçu du fichier exporté ===" -ForegroundColor Yellow
Import-Csv -Path $exportFile | Select-Object -First 5 | Format-Table -AutoSize
