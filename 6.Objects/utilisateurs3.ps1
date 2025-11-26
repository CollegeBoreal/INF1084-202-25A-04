# 1️⃣ Autoriser RDP sur la machine
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" `
                 -Value 0

# 2️⃣ Autoriser le firewall RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# 3️⃣ Exporter la stratégie locale
secedit /export /cfg C:\secpol.cfg

# 4️⃣ Ajouter le groupe Students au droit RDP 
# Dans le fichier secpol.cfg, il faut modifier la ligne :
#   SeRemoteInteractiveLogonRight = Students

# On va parser le fichier automatiquement :
(Get-Content C:\secpol.cfg) `
| ForEach-Object { $_ -replace '^SeRemoteInteractiveLogonRight.*', 'SeRemoteInteractiveLogonRight = Students' } `
| Set-Content C:\secpol.cfg

# 5️⃣ Réimporter la stratégie
secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite

# 6️⃣ Mise à jour de la stratégie
gpupdate /force
