
Write-Host "=== Script utilisateurs4.ps1 ==="

# Activer RDP
Write-Host "Activation du Remote Desktop..."
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" -Value 0

# Activer le firewall RDP
Write-Host "Activation du firewall RDP..."
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Autoriser le groupe Students à utiliser RDP
Write-Host "Ajout du groupe Students aux droits RDP..."
secedit /export /cfg C:\secpol.cfg

# Modifie le fichier pour ajouter Students au droit SeRemoteInteractiveLogonRight
(Get-Content C:\secpol.cfg).Replace(
    "SeRemoteInteractiveLogonRight =",
    "SeRemoteInteractiveLogonRight = *S-1-5-32-545,*$((Get-ADGroup Students).SID)"
) | Set-Content C:\secpol.cfg

secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite

Write-Host "=== Script terminé ==="
