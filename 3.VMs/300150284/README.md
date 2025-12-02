# INF1084 – Administration Windows

## Participation Active Directory

Nom : Aroua Mohand Tahar
Matricule : 300150284
Date : 2 décembre 2025

🧩 Installation et configuration du domaine Active Directory
Domaine créé

Nom du domaine : 300150284-00.local

Contrôleur de domaine : DC300150284-00

DNS intégré et opérationnel ✅

⚙️ Étapes réalisées

Configuration réseau statique

IP : 10.7.236.228

Masque : 255.255.254.0 (/23)

Passerelle : 10.7.237.1

DNS : 10.7.236.228 (après promotion)

Renommage du serveur

Rename-Computer -NewName "DC300150284-00" -Restart


Installation du rôle AD DS

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools


Création du domaine

Install-ADDSForest `
    -DomainName "300150284-00.local" `
    -DomainNetbiosName "300150284-00" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
    -Force


Vérifications PowerShell réussies

Get-ADDomain ✅
![wait](https://github.com/user-attachments/assets/25f7d2aa-0467-4baa-99b1-9a1f5dcec4ed)


Get-ADForest ✅
![wait](https://github.com/user-attachments/assets/50987866-11be-42a0-8151-458be1236d42)


Get-DnsServerZone ✅
![wait](https://github.com/user-attachments/assets/1956cbbc-9bad-4b8e-bea4-f8b9d4fcff91)


💬 Commentaire

Le contrôleur de domaine fonctionne correctement : AD DS est installé, le DNS est opérationnel, et toutes les vérifications ont été validées avec succès.
