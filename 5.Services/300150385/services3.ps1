# Créer le dossier Logs si nécessaire
New-Item -ItemType Directory -Path "C:\Logs" -Force

# Exporter 50 événements AD dans un fichier CSV
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Export-Csv -Path "C:\Logs\AD_Logs.csv" -NoTypeInformation
