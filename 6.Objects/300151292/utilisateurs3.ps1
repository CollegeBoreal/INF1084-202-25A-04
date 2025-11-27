Set-ItemProperty `
    -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" `
    -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

secedit /export /cfg C:\secpol.cfg

# Modifier dans le fichier :
# SeRemoteInteractiveLogonRight = Students

secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite

gpupdate /force

