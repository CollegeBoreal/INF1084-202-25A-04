# TP Services AD - Étape 3
# Auteur : Abdelatif Nemous - 300150417

# Créer le dossier Logs s’il n’existe pas
New-Item -Path "C:\" -Name "Logs" -ItemType Directory -ErrorAction SilentlyContinue

# Exporter les 50 derniers événements AD dans un fichier CSV
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation

Write-Host "✅ Export terminé : C:\Logs\ADLogs.csv"
