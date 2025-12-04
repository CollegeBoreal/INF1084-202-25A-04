# VERIFY TRUST BETWEEN TWO DOMAINS
# Local Domain: DC300147786-00.local
# Remote Domain: DC300147629-00.local
# ===============================

# For proper UTF-8 encoding in console
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$LocalDomain  = "DC300147786-00.local"
$RemoteDomain = "DC300147629-00.local"

Write-Host "=== Vérification DNS du domaine distant ===" -ForegroundColor Cyan
try {
    $dnsResult = Resolve-DnsName $RemoteDomain -ErrorAction Stop
    Write-Host "DNS OK : $RemoteDomain résolu en $($dnsResult.IPAddress)" -ForegroundColor Green
} catch {
    Write-Host "Erreur DNS : impossible de résoudre $RemoteDomain" -ForegroundColor Red
    exit 1
}

Write-Host "=== Vérification du trust avec NETDOM ===" -ForegroundColor Cyan
netdom trust $LocalDomain /Domain:$RemoteDomain /Verify

if ($LASTEXITCODE -eq 0) {
    Write-Host "Trust entre $LocalDomain et $RemoteDomain vérifié avec succès ✅" -ForegroundColor Green
} else {
    Write-Host "Échec de la vérification du trust ❌" -ForegroundColor Red
    Write-Host "Veuillez vérifier la configuration du trust et la connectivité réseau."
}

