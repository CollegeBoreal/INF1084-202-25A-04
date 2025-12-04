# ===============================
# VERIFY TRUST BETWEEN TWO DOMAINS
# Local Domain: DC300147786-00.local
# Remote Domain: DC300147629-00.local
# ===============================

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
# On teste le trust bidirectionnel
$trustCheck = netdom trust $LocalDomain /Domain:$RemoteDomain /Verify

if ($trustCheck -match "The command completed successfully") {
    Write-Host "Trust entre $LocalDomain et $RemoteDomain vérifié avec succès ✅" -ForegroundColor Green
} else {
    Write-Host "Échec de la vérification du trust ❌" -ForegroundColor Red
    Write-Host $trustCheck
}

