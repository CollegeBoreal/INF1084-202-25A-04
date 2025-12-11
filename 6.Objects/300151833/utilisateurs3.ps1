# Activation RDP + droits groupe Students
# ==============================

. "$PSScriptRoot\bootstrap.ps1"

Write-Host "`n=== Activation du RDP ===`n"

# Activer RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" `
                 -Value 0

# Firewall
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "RDP activé et firewall configuré."

# ==============================
# Droits RDP pour le groupe
# ==============================

Write-Host "`n=== Attribution des droits au groupe Students ===`n"

# Export de la stratégie
secedit /export /cfg C:\secpol.cfg

# ⚠️ Dans C:\secpol.cfg tu dois vérifier :
# SeRemoteInteractiveLogonRight = Students

# Réimportation
secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite

Write-Host "Droits RDP appliqués pour le groupe Students."
