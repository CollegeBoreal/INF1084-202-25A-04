# Auteur : 300145940

###################################
# Section A : Préparation du dossier
###################################

$destination = "C:\Logs"
$csvFile = Join-Path $destination "ADLogs.csv"

# Création du dossier si non existant (méthode alternative)
If (!(Test-Path -Path $destination -PathType Container)) {
    [System.IO.Directory]::CreateDirectory($destination) | Out-Null
}

###################################
# Section B : Exportation des logs
###################################

# Paramètres de récupération
$eventLimit = 50
$logType = "Application"

# Récupérer les événements (+ conversion en CSV propre)
Get-WinEvent -LogName $logType -MaxEvents $eventLimit |
    Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message |
    Export-Csv -Path $csvFile -Encoding UTF8 -NoTypeInformation
# Auteur : Haroune Berkani (300141570)

# Step 1 : Vérifier l’existence du dossier de logs et le créer si nécessaire
$logPath = "C:\Logs"
if (-not (Test-Path $logPath)) {
    New-Item -ItemType Directory -Path $logPath -Force
}

# Step 2 : Exporter les 50 derniers événements dans un fichier CSV
Get-EventLog -LogName Application -Newest 50 | Export-Csv -Path "$logPath\ADLogs.csv" -NoTypeInformation
