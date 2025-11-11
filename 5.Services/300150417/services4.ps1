# TP Services AD - Étape 4
# Auteur : Abdelatif Nemous - 300150417

# Arrêter le service DFSR
Stop-Service -Name DFSR

# Vérifier l’état du service après arrêt
(Get-Service -Name DFSR).Status

# Redémarrer le service DFSR
Start-Service -Name DFSR

# Vérifier l’état après redémarrage
(Get-Service -Name DFSR).Status

Write-Host "✅ Le service DFSR a été redémarré avec succès."
