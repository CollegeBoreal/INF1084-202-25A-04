###############################################
# TP Active Directory – Activation du RDP
# Étudiant : 300151292
# Script : utilisateurs3.ps1
###############################################

Write-Host "🔵 Activation du RDP..." -ForegroundColor Cyan

# Activer la connexion RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" -Value 0

# Activer le pare-feu RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Exporter la configuration locale
secedit /export /cfg C:\secpol.cfg

Write-Host "🟡 Édite C:\secpol.cfg et ajoute : SeRemoteInteractiveLogonRight = Students" -ForegroundColor Yellow

# Importer les modifications
secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite

# Mise à jour des stratégies
gpupdate /force

Write-Host "🟢 Fin de utilisateurs3.ps1 — RDP entièrement configuré" -ForegroundColor Green
