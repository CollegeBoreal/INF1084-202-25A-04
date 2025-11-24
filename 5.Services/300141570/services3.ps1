# Auteur : Haroune Berkani (300141570)

# Step 1 : Vérifier l’existence du dossier de logs et le créer si nécessaire
$logPath = "C:\Logs"
if (-not (Test-Path $logPath)) {
    New-Item -ItemType Directory -Path $logPath -Force
}

# Step 2 : Exporter les 50 derniers événements dans un fichier CSV
Get-EventLog -LogName Application -Newest 50 | Export-Csv -Path "$logPath\ADLogs.csv" -NoTypeInformation
