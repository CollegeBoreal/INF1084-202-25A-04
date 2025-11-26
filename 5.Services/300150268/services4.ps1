# Stopper le service DFSR
Stop-Service -Name DFSR

# Vérifier l’état du service
(Get-Service -Name DFSR).Status

# Redémarrer le service DFSR
Start-Service -Name DFSR
