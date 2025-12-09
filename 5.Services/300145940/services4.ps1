# Auteur : 300145940

#######################################
# Bloc A : Cible du service
#######################################
$svc = "DFSR"

#######################################
# Bloc B : Mise en pause du service
#######################################
Try {
    Stop-Service -InputObject (Get-Service $svc) -ErrorAction Stop
} Catch {
    Write-Warning "Impossible d'arrêter le service $svc : $($_.Exception.Message)"
}

#######################################
# Bloc C : Affichage de l'état actuel
#######################################
$status = (Get-Service -Name $svc).Status
Write-Output "État après l'arrêt : $status"

#######################################
# Bloc D : Redémarrage du service
#######################################
Try {
    Start-Service -InputObject (Get-Service $svc) -ErrorAction Stop
} Catch {
    Write-Warning "Impossible de démarrer le service $svc : $($_.Exception.Message)"
}

#######################################
# Bloc E : Vérification finale
#######################################
(Get-Service -Name $svc).Status

