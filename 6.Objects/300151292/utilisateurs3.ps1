# utilisateurs3.ps1
# TP 6.Objects - Activation du RDP pour le groupe Students

# Activer RDP sur la machine
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

# Autoriser le Firewall RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Ajouter le groupe Students aux autorisations RDP (Remote Interactive Logon)
# Exporter la politique de sécurité locale
secedit /export /cfg C:\secpol.cfg

# Modifier le fichier pour ajouter "Students" à : SeRemoteInteractiveLogonRight
# L’utilisateur doit l’éditer manuellement dans le fichier C:\secpol.cfg
# Exemple de ligne modifiée :
# SeRemoteInteractiveLogonRight = *S-1-5-32-544,*S-1-5-32-555,Students

# Réimporter la politique modifiée
secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite

# Mise à jour de la stratégie locale
gpupdate /force
