# TP Services AD - Boudeuf Imad 300152410
# Arrêt du service DFSR puis vérification de son statut

Stop-Service -Name DFSR
(Get-Service -Name DFSR).Status
Write-Host "Service DFSR arrêté"
