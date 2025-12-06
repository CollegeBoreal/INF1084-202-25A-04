# Auteur : 300150284
# TP Services 3
# Lister les services selon l'état

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Running","Stopped")]
    [string]$State
)

Get-Service | Where-Object { $_.Status -eq $State }
