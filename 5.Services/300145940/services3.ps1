# Auteur : 300145940
$svc = "DFSR"

Write-Host "---------------------------"
Write-Host " SERVICE CHECK : $svc"
Write-Host "---------------------------`n"

# Status BEFORE
$before = (Get-Service -Name $svc).Status
Write-Host "État avant : $before`n"

############################
# STOP SERVICE
############################
Write-Host "🛑 Tentative d'arrêt du service..."
Stop-Service -Name $svc -ErrorAction SilentlyContinue

Start-Sleep -Seconds 1

# Status AFTER stop
$afterStop = (Get-Service -Name $svc).Status
Write-Host "État après l'arrêt : $afterStop`n"


############################
# START SERVICE
############################
Write-Host "▶️ Tentative de démarrage..."
Start-Service -Name $svc -ErrorAction SilentlyContinue

Start-Sleep -Seconds 1

# FINAL STATUS
$final = (Get-Service -Name $svc).Status
Write-Host "État après démarrage : $final`n"

Write-Host "---------------------------"
Write-Host " SCRIPT TERMINÉ ✓"
Write-Host "---------------------------"

