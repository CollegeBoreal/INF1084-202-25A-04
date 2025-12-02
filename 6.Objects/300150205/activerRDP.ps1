# ============================
# Script activerRDP.ps1
# ============================

. .\bootstrap.ps1
Write-Output "Bootstrap chargé."

Write-Output "Activation du Remote Desktop"
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

Write-Output "Activation firewall RDP"
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Output "Désactivation de NLA (Network Level Authentication)"
# Note: NLA désactivé pour permettre l'authentification des utilisateurs non-administrateurs
# Dans un environnement de production, il faudrait configurer correctement la GPO
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 0
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 0

Write-Output "Configuration des droits RDP pour le groupe Students"

# Obtenir le SID du groupe Students
$studentsGroup = Get-ADGroup -Identity "Students"
$studentsSID = $studentsGroup.SID.Value
Write-Output "SID du groupe Students: $studentsSID"

# Créer le fichier de politique de sécurité
$secTemplate = @"
[Unicode]
Unicode=yes
[Version]
signature="`$CHICAGO`$"
Revision=1
[Privilege Rights]
SeRemoteInteractiveLogonRight = *S-1-5-32-544,*$studentsSID
"@

# Appliquer la politique
Set-Content -Path "C:\rdp_policy.inf" -Value $secTemplate -Encoding Unicode
secedit /configure /db C:\rdp.sdb /cfg C:\rdp_policy.inf /areas USER_RIGHTS /overwrite /quiet

# Nettoyer les fichiers temporaires
Remove-Item C:\rdp_policy.inf, C:\rdp.sdb -Force -ErrorAction SilentlyContinue

Write-Output "Redémarrage du service Terminal Services"
Restart-Service TermService -Force

Write-Output "Mise à jour des politiques"
gpupdate /force | Out-Null

Write-Output ""
Write-Output "========================================="
Write-Output "Configuration RDP terminée avec succès!"
Write-Output "========================================="
Write-Output ""
Write-Output "Les utilisateurs du groupe Students peuvent maintenant se connecter via RDP"
Write-Output ""
Write-Output "Format de connexion:"
Write-Output "  Serveur: 10.7.236.226 (ou $env:COMPUTERNAME)"
Write-Output "  Utilisateur: Etudiant1@$env:USERDNSDOMAIN"
Write-Output "  Mot de passe: Pass123!"
Write-Output ""
Write-Output "IMPORTANT: Utilisez le format UPN complet (utilisateur@domaine.local)"
Write-Output ""
Write-Output "========================================="