# ==========================================
# Script : rdp.ps1
# Objectif : Activer RDP et donner l'accès
#            au groupe Students
# ==========================================

Write-Host "Activation de RDP..." -ForegroundColor Cyan

# 1️⃣ Activer RDP sur la machine
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

# 2️⃣ Activer le firewall pour Remote Desktop
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "Firewall RDP activé." -ForegroundColor Green

# 3️⃣ Donner l'accès RDP au groupe Students
# ⚠ Nécessite ntrights.exe (dans Windows Server Resource Kit Tools)

$Group = "Students"

Write-Host "Assignation du droit RDP (SeRemoteInteractiveLogonRight) au groupe $Group" -ForegroundColor Cyan

ntrights.exe +r SeRemoteInteractiveLogonRight -u $Group

Write-Host "Le groupe $Group est maintenant autorisé à utiliser RDP." -ForegroundColor Green

# ==========================================
# Fin du script
# ==========================================

