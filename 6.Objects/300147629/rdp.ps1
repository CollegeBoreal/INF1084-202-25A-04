# ==========================================
# Script : rdp.ps1
# Objectif : Activer RDP et donner l'accès
#            au groupe Students
# ==========================================

Write-Host "Activation de RDP..." -ForegroundColor Cyan

# Activer RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

# Activer le firewall RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "Firewall RDP activé." -ForegroundColor Green

# Donner le droit RDP au groupe Students
$Group = "Students"

Write-Host "Assignation du droit RDP au groupe $Group..." -ForegroundColor Cyan

ntrights.exe +r SeRemoteInteractiveLogonRight -u $Group

Write-Host "Le groupe $Group possède maintenant l'accès RDP." -ForegroundColor Green

# ==========================================
# Fin
# ==========================================

