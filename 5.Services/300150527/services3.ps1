# services3.ps1 - 300150527
# Objectif : Exporter les événements AD et vérifier la création du fichier.

# 1. Créer le dossier C:\Logs s'il n'existe pas
if (!(Test-Path -Path "C:\Logs")) {
    New-Item -ItemType Directory -Path "C:\Logs" | Out-Null
}

# 2. Exporter les événements Directory Service vers CSV
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation

# 3. Vérifier que le dossier existe
Test-Path C:\Logs

# 4. Lister le contenu (pour confirmer la présence de ADLogs.csv)
Get-ChildItem C:\Logs
