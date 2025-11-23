# services4.ps1
# Arrêter puis redémarrer le service DFSR
Stop-Service -Name DFSR
(Get-Service -Name DFSR).Status
Start-Service -Name DFSR
