# ============================================
# Script : utilisateurs3.ps1
# Objectif : Activer le RDP et autoriser le groupe Students
# Étudiant : Belkacem Medjkoune - 300150385
# ============================================

$GroupName = "Students"

Write-Host "Configuration de l'accès RDP en cours..." -ForegroundColor Cyan

# --- 1. Activation RDP ---
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0
Write-Host "[OK] Le service RDP est activé." -ForegroundColor Green

# --- 2. Activation du Firewall RDP ---
Enable-NetFirewallRule -DisplayGroup "Remote Desktop" | Out-Null
Write-Host "[OK] Règles firewall RDP activées." -ForegroundColor Green

# --- 3. Attribution des droits RDP au groupe Students ---

Write-Host "Mise à jour des droits de connexion pour le groupe Students..." -ForegroundColor Cyan

# Export des politiques locales
$SecFile = "C:\secpol.cfg"
$DbFile  = "C:\secpol.sdb"

secedit /export /cfg $SecFile | Out-Null

# Modification du droit 'SeRemoteInteractiveLogonRight'
$Content = Get-Content $SecFile

# Si la ligne existe déjà
if ($Content -match "SeRemoteInteractiveLogonRight") {
    $Content = $Content -replace "SeRemoteInteractiveLogonRight = .*",
                                "SeRemoteInteractiveLogonRight = *S-1-5-32-544,$GroupName"
}
else {
    # Sinon on ajoute la ligne
    Add-Content -Path $SecFile -Value "SeRemoteInteractiveLogonRight = *S-1-5-32-544,$GroupName"
}

# Écriture finale
Set-Content -Path $SecFile -Value $Content

# Importer la configuration modifiée
secedit /import /cfg $SecFile /db $DbFile /overwrite | Out-Null

Write-Host "[OK] Le groupe $GroupName possède maintenant les droits RDP." -ForegroundColor Green

Write-Host "`n--- Script terminé ---"
