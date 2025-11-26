# services4.ps1 - 300150527
# Objectif : Arrêter et redémarrer le service DFSR et vérifier son état.

# 1. Vérifier l'état initial du service
Get-Service -Name DFSR

# 2. Arrêter le service DFSR
Stop-Service -Name DFSR 

# 3. Vérifier l'état après arrêt
(Get-Service -Name DFSR).Status

# 4. Démarrer le service DFSR
Start-Service -Name DFSR

# 5. Vérifier l'état final
(Get-Service -Name DFSR).Status
