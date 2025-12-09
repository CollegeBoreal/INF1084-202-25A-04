# Vérifie si le dossier C:\Logs existe, sinon le crée
$logPath = "C:\Logs"
if (-not (Test-Path $logPath)) {
    New-Item -ItemType Directory -Path $logPath -Force
}

# Exporte les 50 derniers événements dans un fichier CSV
Get-EventLog -LogName Application -Newest 50 | Export-Csv -Path "$logPath\ADLogs.csv" -NoTypeInformation
