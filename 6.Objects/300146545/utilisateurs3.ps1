# ============================
# Script : utilisateurs3.ps1
# Objet : Activer RDP pour le groupe Students
saouid alaoua 

$GroupName = "Students"

Write-Host "Activation du RDP..." -ForegroundColor Cyan

# 1. Activer RDP sur le serveur
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

Write-Host "RDP activé." -ForegroundColor Green

# 2. Ouvrir le Firewall pour RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop" | Out-Null
Write-Host "Firewall RDP activé." -ForegroundColor Green

# 3. Donner les droits RDP au groupe Students
Write-Host "Assignation des droits RDP au groupe Students..." -ForegroundColor Cyan

# Export de la configuration de sécurité
secedit /export /cfg C:\secpol.cfg

# Ajouter le groupe Students au droit : SeRemoteInteractiveLogonRight
(Get-Content C:\secpol.cfg).Replace("SeRemoteInteractiveLogonRight = ","SeRemoteInteractiveLogonRight = *S-1-5-32-544,$GroupName") | Set-Content C:\secpol.cfg

# Réimporter la configuration modifiée
secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite

Write-Host "Le groupe Students peut maintenant se connecter en RDP." -ForegroundColor Green