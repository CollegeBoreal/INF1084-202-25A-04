# services3.ps1
# Exporter les 50 derniers événements AD dans un fichier CSV
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
