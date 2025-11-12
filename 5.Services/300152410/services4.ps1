# TP Services AD - Boudeuf Imad 300152410
# Redémarrage du service DFSR et vérification finale

Start-Service -Name DFSR
(Get-Service -Name DFSR).Status
Write-Host "Service DFSR redémarré et en cours d’exécution"
