# 300146545 saoudi alaoua 
🧭 TP Active Directory – 6.Objects

Étudiant : 300146545
Instance : 00
Domaine : DC300146545-00.local
NetBIOS : DC300146545-00

🌟 Introduction

Dans ce laboratoire, j’ai appris à manipuler plusieurs objets Active Directory (AD) à l’aide de PowerShell.
L’objectif était de :

créer un dossier de travail et l’envoyer sur GitHub ;

charger mes informations via le fichier bootstrap.ps1 ;

créer un dossier partagé sécurisé ;

créer un groupe AD et deux utilisateurs ;

lier une GPO à l’OU Students pour mapper automatiquement un lecteur réseau Z: ;

activer l’accès RDP pour les étudiants du groupe Students ;

vérifier le bon fonctionnement de toute la configuration.

Ce TP m’a permis de comprendre comment un administrateur réseau gère les objets AD, les permissions, les partages SMB et les stratégies de groupe.

📁 1. Création du dossier du laboratoire

Dans le dossier 6.Objects, j’ai créé ma structure personnelle :

mkdir 300146545
cd 300146545
New-Item -ItemType File -Name README.md
mkdir images
New-Item -ItemType File -Path images\.gitkeep

📌 2. Synchronisation Git
cd ..
git add 300146545
git commit -m "Ajout du labo 6.Objects pour 300146545"
git push

🔧 3. Chargement des modules et variables
Import-Module ActiveDirectory
Import-Module GroupPolicy
. "C:\Users\Administrator\Developer\INF1084-202-25A-04\4.OUs\300146545\bootstrap.ps1"


Vérification des variables :

Write-Host "Student Number : $studentNumber"
Write-Host "Instance       : $studentInstance"
Write-Host "Domain Name    : $domainName"
Write-Host "NetBIOS Name   : $netbiosName"
Write-Host "Credential     : $($cred.username)"

📁 4. Création du dossier partagé, groupe et utilisateurs AD
$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force

Création du groupe Students
$GroupName = "Students"
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

Création des utilisateurs
$Users = @("Etudiant1", "Etudiant2")
foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity $GroupName -Members $user
}

Partage SMB
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

🗂️ 5. Création d’une GPO pour mapper Z:
Création de la GPO
$GPOName = "MapSharedFolder"
New-GPO -Name $GPOName

Lier la GPO à l’OU Students
$OU = "OU=Students,DC=DC300146545-00,DC=local"
New-GPLink -Name $GPOName -Target $OU

Création d'un script de connexion
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder }

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

Associer le script à la GPO
Set-GPRegistryValue -Name $GPOName `
  -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
  -ValueName "LogonScript" `
  -Type String `
  -Value $ScriptPath

🖥️ 6. Activation du RDP pour le groupe Students
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Exporter les stratégies locales
secedit /export /db C:\Windows\security\database\secedit.sdb /cfg C:\secpol.cfg


✔ Modifier la ligne :

SeRemoteInteractiveLogonRight = Students

Réimporter
secedit /import /db C:\Windows\security\database\secedit.sdb /cfg C:\secpol.cfg /overwrite
gpupdate /force
