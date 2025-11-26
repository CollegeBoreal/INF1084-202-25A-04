# utilisateurs4.ps1
# TP 6.Objects - Gestion d'un service Windows

# Nom du service à gérer (DFSR par défaut)
$ServiceName = "DFSR"

# Arrêter le service
Stop-Service -Name $ServiceName -Force

# Vérifier son état
(Get-Service -Name $ServiceName).Status

# Redémarrer le service
Start-Service -Name $ServiceName

# Vérifier à nouveau
(Get-Service -Name $ServiceName).Status
