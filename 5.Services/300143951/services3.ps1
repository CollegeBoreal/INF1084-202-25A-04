# Créer le dossier s'il n'existe pas
$logPath = "C:\Logs"
if (-not (Test-Path $logPath)) {
    New-Item -Path $logPath -ItemType Directory
}

# Exporter avec timestamp dans le nom
$date = Get-Date -Format "yyyyMMdd_HHmmss"
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | 
    Select-Object TimeCreated, Id, LevelDisplayName, Message |
    Export-Csv -Path "C:\Logs\ADLogs_$date.csv" -NoTypeInformation

Write-Host "Logs exportés vers C:\Logs\ADLogs_$date.csv" -ForegroundColor Green
