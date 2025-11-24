# Auteur : Haroune Berkani (300141570)

# Step 1 : Arrêter le service DFSR
Stop-Service -Name DFSR

# Step 2 : Vérifier le statut du service DFSR
(Get-Service -Name DFSR).Status

# Step 3 : Démarrer le service DFSR
Start-Service -Name DFSR
