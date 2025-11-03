# Vérifie si le dossier C:\Logs existe, sinon le crée
if (-not (Test-Path "C:\Logs")) {
    New-Item -Path "C:\Logs" -ItemType Directory | Out-Null
}

# Exporte les 50 derniers événements du journal Directory Service
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation

Write-Host "✅ Export terminé : les logs AD sont enregistrés dans C:\Logs\ADLogs.csv"

