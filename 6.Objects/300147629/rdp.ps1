# ==========================================
# Script : rdp.ps1
# Objectif : Activer RDP et donner l'accès
#            au groupe Students
# ==========================================

Write-Host "Activation de RDP..." -ForegroundColor Cyan

<<<<<<< HEAD
# 1️⃣ Activer RDP sur la machine
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

# 2️⃣ Activer le firewall pour Remote Desktop
=======
# Activer RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

# Activer le firewall RDP
>>>>>>> b866413ea727e9d3b43541a74e97a7a61eccbda9
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "Firewall RDP activé." -ForegroundColor Green

<<<<<<< HEAD
# 3️⃣ Donner l'accès RDP au groupe Students
# ⚠ Nécessite ntrights.exe (dans Windows Server Resource Kit Tools)

$Group = "Students"

Write-Host "Assignation du droit RDP (SeRemoteInteractiveLogonRight) au groupe $Group" -ForegroundColor Cyan

ntrights.exe +r SeRemoteInteractiveLogonRight -u $Group

Write-Host "Le groupe $Group est maintenant autorisé à utiliser RDP." -ForegroundColor Green

# ==========================================
# Fin du script
=======
# Donner le droit RDP au groupe Students
$Group = "Students"

Write-Host "Assignation du droit RDP au groupe $Group..." -ForegroundColor Cyan

ntrights.exe +r SeRemoteInteractiveLogonRight -u $Group

Write-Host "Le groupe $Group possède maintenant l'accès RDP." -ForegroundColor Green

# ==========================================
# Fin
>>>>>>> b866413ea727e9d3b43541a74e97a7a61eccbda9
# ==========================================

