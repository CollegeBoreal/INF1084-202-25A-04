# Arrêter DFSR
Stop-Service -Name DFSR

# Vérifier l'état du service
(Get-Service -Name DFSR).Status

# Redémarrer DFSR
Start-Service -Name DFSR
