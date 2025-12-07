param(
    [string]$LocalForest      = "DC300147786-00.local",
    [string]$LocalDC          = "DC300147786-00-DC01",
    [string]$RemoteForest     = "DC300147629-00.local",
    [string]$RemoteDC         = "DC300147629-00-DC01",
    [ValidateSet("Forest")]
    [string]$TrustType        = "Forest",
    [string]$Direction        = "Bidirectional",
    [bool]  $Transitivity     = $true
)

Write-Host "`n============================" -ForegroundColor Cyan
Write-Host " Vérification de la connectivité réseau " -ForegroundColor Cyan
Write-Host "============================`n" -ForegroundColor Cyan

# Test Ping
if (-not (Test-Connection -ComputerName $RemoteDC -Count 2 -Quiet)) {
    throw "❌ Le contrôleur distant ($RemoteDC) ne répond pas au ping."
} else {
    Write-Host "✔ Ping OK vers $RemoteDC"
}

