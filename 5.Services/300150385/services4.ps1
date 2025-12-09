# Arrêter le service DFSR
Stop-Service -Name DFSR

# Vérifier l’état du service
(Get-Service -Name DFSR).Status

# Redémarrer le service
Start-Service -Name DFSR
