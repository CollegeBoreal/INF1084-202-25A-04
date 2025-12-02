#300147786
# README – Laboratoire : Partage de ressources et RDP via PowerShell

Ce document décrit étape par étape la création d’un dossier partagé, la configuration d’une GPO pour mapper un lecteur réseau, l’activation du RDP pour un groupe d’utilisateurs, puis les tests de validation.

---

## 📁 1. Création du dossier partagé

Script : **utilisateurs1.ps1**

```powershell
# Chemin du dossier
$SharedFolder = "C:\SharedResources"

# Créer le dossier
New-Item -Path $SharedFolder -ItemType Directory -Force

# Créer un partage SMB pour le groupe Students
$GroupName = "Students"

# Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# Créer des utilisateurs AD et les ajouter au groupe
$Users = @("Etudiant1","Etudiant2")
foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity $GroupName -Members $user
}

# Partager le dossier avec le groupe
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
```




## 🗂️ 2. Créer une GPO pour mapper le lecteur réseau

Script : **utilisateurs2.ps1**

```powershell
# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO
New-GPO -Name $GPOName

# Lier la GPO à une OU spécifique
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

# Créer une preference pour mapper le lecteur réseau
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"

# Créer un script logon
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder }

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Lier le script logon à la GPO
Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath
```



## 🖥️ 3. Activer RDP pour le groupe Students

```powershell
# Autoriser RDP sur la machine
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

# Autoriser le firewall RDP\Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Exporter la stratégie locale
secedit /export /cfg C:\secpol.cfg
# Modifier le fichier pour ajouter Students dans SeRemoteInteractiveLogonRight
# Puis réimporter
secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite
```
---

## 🧪 4. Test

Connectez-vous avec un des utilisateurs du groupe **Students**.

### Vérifications :

* ✔️ Le lecteur **Z:** est mappé automatiquement
* ✔️ L’utilisateur peut se connecter en **RDP**

---



