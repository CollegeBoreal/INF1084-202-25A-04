#  README.md  Travail 6.Objects  
### Étudiant : 300150295  Lounes Allouti  
### Cours : INF1084  Administration Windows  Automatisation PowerShell

# 1. Création de la structure AD (OU)
New-ADOrganizationalUnit -Name "College" -ProtectedFromAccidentalDeletion \False
New-ADOrganizationalUnit -Name "Students" -Path "OU=College,DC=dc300150295,DC=local"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=College,DC=dc300150295,DC=local"

# 2. Création des utilisateurs (Étudiants)
New-ADUser -Name "student1" -SamAccountName student1 -Path "OU=Students,OU=College,DC=dc300150295,DC=local" -AccountPassword (Read-Host -AsSecureString) -Enabled \True
New-ADUser -Name "student2" -SamAccountName student2 -Path "OU=Students,OU=College,DC=dc300150295,DC=local" -AccountPassword (Read-Host -AsSecureString) -Enabled \True

# 3. Création du groupe + Partage SMB sécurisé
New-ADGroup -Name "RDPStudents" -GroupScope Global -Path "OU=Groups,OU=College,DC=dc300150295,DC=local"
Add-ADGroupMember -Identity "RDPStudents" -Members student1, student2

New-Item -Path "C:\Share" -ItemType Directory
New-SmbShare -Name "Share" -Path "C:\Share" -FullAccess "RDPStudents"
icacls C:\Share /grant "RDPStudents:(OI)(CI)M"

# 4. GPO : lecteur réseau mappé automatiquement
# User Configuration  Preferences  Windows Settings  Drive Maps
# Lettre: Z:, Chemin: \\SRV-DC\Share, Groupe: RDPStudents

# 5. Restriction RDP au groupe Students
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
net localgroup "Remote Desktop Users" /add "dc300150295\RDPStudents"

# 6.  Tests effectués
# Avec un utilisateur du groupe Students  RDP OK, lecteur Z: OK, accès SMB OK
# Avec un utilisateur hors du groupe  RDP refusé, lecteur Z: absent, accès SMB refusé

#  Conclusion
# Ce laboratoire ma permis de :
# - créer des objets AD (OU, utilisateurs, groupes)
# - configurer un partage SMB sécurisé
# - appliquer une GPO avec un lecteur réseau automatique
# - activer et restreindre l'accès RDP
# - automatiser entièrement linfrastructure via PowerShell
