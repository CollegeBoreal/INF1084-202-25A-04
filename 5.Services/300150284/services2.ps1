# Auteur : 300150284
# TP Services 2
# Démarrer ou arrêter un service

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("start","stop")]
    [string]$Action,

    [Parameter(Mandatory=$true)]
    [string]$ServiceName
)

if ($Action -eq "start") {
    Start-Service -Name $ServiceName
    Write-Host "Service $ServiceName démarré."
}
elseif ($Action -eq "stop") {
    Stop-Service -Name $ServiceName
    Write-Host "Service $ServiceName arrêté."
}
else {
    Write-Host "Action invalide. Utilisez start ou stop."
}
