🧮 TP – Objets AD, Partage de ressources et RDP via PowerShell

Auteur : 300150284
Cours : INF1084 – Administration Windows

🎯 Objectifs du laboratoire

Ce laboratoire a pour but d’automatiser la gestion d’Active Directory en PowerShell :

Créer un dossier partagé dans le serveur

Créer un groupe AD et des utilisateurs

Mapper automatiquement un lecteur réseau via GPO

Activer l’accès RDP pour un groupe d’utilisateurs

Tester les fonctionnalités avec un utilisateur du groupe

📁 Structure du répertoire
6.Objects/
 └── 300150284/
      ├── README.md
      ├── utilisateurs1.ps1
      ├── utilisateurs2.ps1
      ├── utilisateurs3.ps1
      ├── utilisateurs4.ps1
      

🧩 1️⃣ Script : utilisateurs1.ps1
✔ Objectif :

Créer un dossier partagé, un groupe AD Students, et deux utilisateurs (Etudiant1, Etudiant2).

📜 Code PowerShell :
# Auteur : 300150284
# TP Objets AD – Script 1
# Création du dossier partagé + groupe Students + utilisateurs

Import-Module ActiveDirectory

# 1. Créer le dossier partagé
$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force

# 2. Créer le groupe Students
$GroupName = "Students"
if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'")) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Étudiants pour partage et RDP"
}

# 3. Créer utilisateurs
$Users = @("Etudiant1","Etudiant2")
foreach ($u in $Users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$u'")) {
        New-ADUser -Name $u -SamAccountName $u -Enabled $true `
            -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force)
    }
    Add-ADGroupMember -Identity $GroupName -Members $u -ErrorAction SilentlyContinue
}

# 4. Créer le partage SMB
if (-not (Get-SmbShare | Where-Object { $_.Name -eq "SharedResources" })) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
}

📸 Capture d’écran

➡️ Colle la capture ici :
![wait](https://github.com/user-attachments/assets/29b542f3-9313-4b89-8e5e-21e1a5dc76dc)
 

🧩 2️⃣ Script : utilisateurs2.ps1
✔ Objectif :

Créer une GPO qui mappe automatiquement un lecteur réseau Z: pour les utilisateurs du groupe Students.

📜 Code PowerShell :
# Auteur : 300150284
# TP Objets AD – Script 2
# Créer une GPO pour mapper un lecteur réseau automatiquement

Import-Module GroupPolicy

$GPOName = "MapSharedFolder"
$Domain = (Get-ADDomain).DNSRoot
$OU = "OU=Students,DC=" + $Domain.Replace(".",",DC=")

# 1. Créer la GPO si elle n'existe pas
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName
}

# 2. Lier la GPO à l’OU Students
New-GPLink -Name $GPOName -Target $OU -ErrorAction SilentlyContinue

# 3. Créer un script de logon pour mapper Z:
$DriveLetter = "Z:"
$SharePath = "\\$env:COMPUTERNAME\SharedResources"

$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder }

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

📸 Capture d’écran

➡️ Colle la capture ici :
![wait](https://github.com/user-attachments/assets/aa29a9ce-7894-4d54-b88a-d32ac4e8aba8)

 

🧩 3️⃣ Script : utilisateurs3.ps1
✔ Objectif :

Exporter les événements AD (Directory Service) dans un fichier CSV.

📜 Code PowerShell :
# Auteur : 300150284
# TP Objets AD – Script 3
# Exporter les logs AD dans un fichier CSV

$OutputFile = "C:\Logs\ADLogs.csv"

if (-not (Test-Path "C:\Logs")) {
    New-Item -ItemType Directory -Path "C:\Logs"
}

Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
    Export-Csv -Path $OutputFile -NoTypeInformation

Write-Host "Export terminé : $OutputFile"

📸 Capture d’écran

➡️ Colle la capture ici :

![wait](https://github.com/user-attachments/assets/077f44a1-a587-4eb7-b4e9-d8a6065d4bf0)


🧩 4️⃣ Script : utilisateurs4.ps1
✔ Objectif :

Activer l’accès RDP pour le groupe Students.

📜 Code PowerShell :
# Auteur : 300150284
# TP Objets AD – Script 4
# Activer RDP pour le groupe Students

# Activer RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" -Value 0

# Activer firewall RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Ajouter Students au groupe RDP
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "Students"

📸 Capture d’écran

➡️ Colle la capture ici :
![wait](https://github.com/user-attachments/assets/5e9ff900-d3d4-4e4e-b8d6-731995c02356)

🧪 Tests

✔ Connexion avec Etudiant1 ou Etudiant2
✔ Le lecteur Z: est automatiquement mappé
✔ L’utilisateur peut ouvrir Remote Desktop (RDP)
✔ Un utilisateur hors du groupe Students ne peut PAS se connecter

 
🧷 Conclusion

Ce laboratoire permet de :

Gérer AD entièrement via PowerShell

Automatiser la création d’utilisateurs et de groupes

Déployer des GPO sans interface graphique

Configurer un partage réseau

Permettre l’accès RDP à un groupe spécifique

Un excellent exercice pour la compréhension des objets AD, GPO et administration Windows automatisée.
