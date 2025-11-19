 # Charger la configuration
. .\bootstrap.ps1

Write-Host "`n=== Configuration RDP ===" -ForegroundColor Cyan

# Activer RDP
Write-Host "Activation de RDP..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" `
                 -Value 0
Write-Host "✓ RDP activé" -ForegroundColor Green

# Autoriser le firewall RDP
Write-Host "`nConfiguration du pare-feu..." -ForegroundColor Yellow
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "✓ Règles de pare-feu activées" -ForegroundColor Green

Write-Host "`n=== Attribution des droits RDP ===" -ForegroundColor Cyan

# Ajouter le groupe au groupe local "Remote Desktop Users"
$GroupName = "Students"
try {
    Add-LocalGroupMember -Group "Remote Desktop Users" `
                         -Member "$netbiosName\$GroupName" `
                         -ErrorAction Stop
    Write-Host "✓ Groupe $GroupName ajouté à 'Remote Desktop Users'" -ForegroundColor Green
} catch {
    Write-Host "⚠ Le groupe est peut-être déjà membre" -ForegroundColor Yellow
}

Write-Host "`n=== Configuration RDP terminée ===" -ForegroundColor Green