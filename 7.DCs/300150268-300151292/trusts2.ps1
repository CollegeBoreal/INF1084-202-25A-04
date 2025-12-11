# Script : trusts2.ps1
# Vérification du trust forestier

$Forest1 = "DC300151292-00.local"
$Forest2 = "DC300150268-40.local"

Write-Host "`n--- Vérification NETDOM ---" -ForegroundColor Cyan
cmd.exe /c "netdom trust $Forest1 /domain:$Forest2 /verify"

Write-Host "`n--- Vérification AD (Get-ADTrust) ---" -ForegroundColor Cyan
Get-ADTrust -Filter * | Where-Object { $_.Target -eq $Forest2 }

Write-Host "`n--- Vérification des domaines de confiance (nltest) ---" -ForegroundColor Cyan
nltest /trusted_domains
