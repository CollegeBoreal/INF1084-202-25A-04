# 🧠 Laboratoire Active Directory : Objets gérables et GPO

## 👤 Étudiant

* **Nom :** HAMMICHE
* **Prénom :** MOHAND L'hacene
* **ID Étudiant :** 300151492

---

## 🌐 Sujet du laboratoire

**Titre :** Objets gérables par Active Directory et automatisation via GPO (Group Policy Object)
Ce laboratoire vise à manipuler les principaux objets Active Directory (utilisateurs, groupes, OU, ordinateurs, etc.) et à automatiser la gestion des ressources réseau à l'aide de PowerShell et des GPO.

---

## 🎯 Objectifs

1. Comprendre les objets AD et leur utilité.
2. Créer et partager un dossier réseau SMB.
3. Créer des utilisateurs et groupes AD.
4. Mapper un lecteur réseau (Z:) via un GPO.
5. Activer le RDP pour un groupe spécifique.
6. Tester les accès et permissions.

---

## 🧩 Environnement requis

* Windows Server 2022 avec AD DS installé
* Modules PowerShell : `ActiveDirectory`, `GroupPolicy`
* VM membre du domaine pour les tests
* Domaine : `DC300151492-00.local`
* OU : `Students`

---

## 🏗️ Étapes du laboratoire

### 1️⃣ Création du dossier partagé et du groupe AD

**Script : `utilisateurs1.ps1`**
```powershell
# Source le bootstrap
. .\bootstrap.ps1

$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force

$GroupName = "Students"
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

$Users = @("Etudiant1","Etudiant2")
foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
    Add-ADGroupMember -Identity $GroupName -Members $user
}

New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
```

### 2️⃣ Création du GPO pour mapper le lecteur réseau

**Script : `utilisateurs2.ps1`**
```powershell
# Source le bootstrap
. .\bootstrap.ps1

$GPOName = "MapSharedFolder"
New-GPO -Name $GPOName

$OU = "OU=Students,DC=DC300151492-00,DC=local"
New-GPLink -Name $GPOName -Target $OU

$DriveLetter = "Z:"
$SharePath = "\\DC300151492-00\SharedResources"

$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder }

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath
```

### 3️⃣ Activation du RDP pour le groupe Students

**Script : `rdp-config.ps1`**
```powershell
# Source le bootstrap
. .\bootstrap.ps1

Write-Host "`n=== Configuration RDP complete sur Domain Controller ===" -ForegroundColor Cyan

try {
    # 1. Activer RDP
    Write-Host "`n1. Activation de RDP..." -ForegroundColor Yellow
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
    Write-Host "   RDP active" -ForegroundColor Green
    
    # 2. Autoriser RDP dans le firewall
    Write-Host "`n2. Configuration du firewall..." -ForegroundColor Yellow
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    Write-Host "   Firewall configure" -ForegroundColor Green
    
    # 3. Ajouter Students au groupe AD "Remote Desktop Users"
    Write-Host "`n3. Ajout du groupe Students a Remote Desktop Users..." -ForegroundColor Yellow
    Add-ADGroupMember -Identity "Remote Desktop Users" -Members "Students" -ErrorAction SilentlyContinue
    Write-Host "   Groupe ajoute" -ForegroundColor Green
    
    # 4. CRITIQUE : Donner le droit de connexion RDP via secedit
    Write-Host "`n4. Configuration des droits d'ouverture de session RDP..." -ForegroundColor Yellow
    
    # Obtenir le SID du groupe Students
    $StudentsSID = (Get-ADGroup -Identity "Students").SID.Value
    Write-Host "   SID du groupe Students: $StudentsSID" -ForegroundColor Cyan
    
    # Export de la configuration actuelle
    secedit /export /cfg C:\secpol.cfg /quiet
    
    # Lire et modifier
    $content = Get-Content C:\secpol.cfg
    $newContent = $content | ForEach-Object {
        if ($_ -match "^SeRemoteInteractiveLogonRight") {
            if ($_ -notmatch $StudentsSID) {
                $_ + ",*$StudentsSID"
            } else {
                $_
            }
        } else {
            $_
        }
    }
    
    # Sauvegarder et réimporter
    $newContent | Set-Content C:\secpol.cfg
    secedit /configure /db C:\secpol.sdb /cfg C:\secpol.cfg /areas USER_RIGHTS /quiet
    
    Write-Host "   Droits RDP configures" -ForegroundColor Green
    
    # Nettoyer
    Remove-Item C:\secpol.cfg -ErrorAction SilentlyContinue
    Remove-Item C:\secpol.sdb -ErrorAction SilentlyContinue
    
    # 5. Forcer la mise à jour
    Write-Host "`n5. Mise a jour des strategies..." -ForegroundColor Yellow
    gpupdate /force | Out-Null
    Write-Host "   Strategies mises a jour" -ForegroundColor Green
    
    # 6. Vérification
    Write-Host "`n=== VERIFICATION ===" -ForegroundColor Cyan
    
    Write-Host "`nMembres du groupe Remote Desktop Users:" -ForegroundColor Yellow
    Get-ADGroupMember -Identity "Remote Desktop Users" | Select Name, SamAccountName | Format-Table
    
    Write-Host "Membres du groupe Students:" -ForegroundColor Yellow
    Get-ADGroupMember -Identity "Students" | Select Name, SamAccountName | Format-Table
    
    Write-Host "Statut RDP:" -ForegroundColor Yellow
    $rdpStatus = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections"
    if ($rdpStatus.fDenyTSConnections -eq 0) {
        Write-Host "RDP est ACTIVE" -ForegroundColor Green
    } else {
        Write-Host "RDP est DESACTIVE" -ForegroundColor Red
    }
    
    Write-Host "`nDroits d'ouverture de session RDP:" -ForegroundColor Yellow
    secedit /export /cfg C:\temp_check.cfg /quiet
    $rdpRights = Get-Content C:\temp_check.cfg | Select-String "SeRemoteInteractiveLogonRight"
    Write-Host $rdpRights -ForegroundColor Cyan
    Remove-Item C:\temp_check.cfg -ErrorAction SilentlyContinue
    
    Write-Host "`n=== Configuration RDP TERMINEE ===" -ForegroundColor Green
    
} catch {
    Write-Host "`nERREUR: $_" -ForegroundColor Red
}
```

---

## 🔑 Problème rencontré et solution

### ❌ Problème initial
Les utilisateurs Etudiant1 et Etudiant2 ne pouvaient pas se connecter en RDP malgré :
- RDP activé sur le serveur
- Firewall configuré correctement
- Groupe Students membre de "Remote Desktop Users"

### 🔍 Cause identifiée
Le groupe Students n'avait pas le droit **SeRemoteInteractiveLogonRight** nécessaire pour ouvrir une session RDP sur le Domain Controller.

**Vérification du problème :**
```powershell
secedit /export /cfg C:\secpol.cfg
Get-Content C:\secpol.cfg | Select-String "SeRemoteInteractiveLogonRight"
# Résultat : SeRemoteInteractiveLogonRight = *S-1-5-32-544
# (Seul le groupe Administrators avait ce droit)
```

### ✅ Solution - Les 2 commandes critiques

**Commande 1 : Ajouter Students au groupe Remote Desktop Users**
```powershell
Add-ADGroupMember -Identity "Remote Desktop Users" -Members "Students"
```

**Commande 2 : Donner le droit SeRemoteInteractiveLogonRight via secedit**
```powershell
# Obtenir le SID du groupe Students
$StudentsSID = (Get-ADGroup -Identity "Students").SID.Value

# Exporter la configuration actuelle
secedit /export /cfg C:\secpol.cfg

# Modifier le fichier pour ajouter le SID de Students
$content = Get-Content C:\secpol.cfg
$newContent = $content | ForEach-Object {
    if ($_ -match "^SeRemoteInteractiveLogonRight") {
        $_ + ",*$StudentsSID"
    } else {
        $_
    }
}

# Sauvegarder et importer la nouvelle configuration
$newContent | Set-Content C:\secpol.cfg
secedit /configure /db C:\secpol.sdb /cfg C:\secpol.cfg /areas USER_RIGHTS

# Forcer la mise à jour
gpupdate /force
```

**Résultat après correction :**
```
SeRemoteInteractiveLogonRight = Students,*S-1-5-32-544
```

---

## ✅ Vérifications et tests

### Tests effectués :

* ✅ Connexion RDP avec **Etudiant1** (Pass123!)
* ✅ Connexion RDP avec **Etudiant2** (Pass123!)
* ✅ Le lecteur Z: est mappé automatiquement vers `\\DC300151492-00\SharedResources`
* ✅ Accès au dossier partagé fonctionnel
* ✅ Groupe Students membre de "Remote Desktop Users"
* ✅ Droit SeRemoteInteractiveLogonRight accordé au groupe Students

### Test d'un utilisateur hors du groupe :

* ❌ Pas d'accès RDP
* ❌ Aucun lecteur réseau mappé

---

## 📘 Commandes PowerShell utiles

| Action                                 | Commande                                                                                                           |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| Vérifier les membres du groupe         | `Get-ADGroupMember -Identity "Students"`                                                                           |
| Vérifier Remote Desktop Users          | `Get-ADGroupMember -Identity "Remote Desktop Users"`                                                               |
| Vérifier le statut RDP                 | `Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections"`      |
| Vérifier les droits RDP                | `secedit /export /cfg C:\temp.cfg; Get-Content C:\temp.cfg \| Select-String "SeRemoteInteractiveLogonRight"`      |
| Lister toutes les GPO                  | `Get-GPO -All`                                                                                                     |
| Afficher une GPO spécifique            | `Get-GPO -Name "MapSharedFolder"`                                                                                  |
| Lier une GPO à une OU                  | `New-GPLink -Name "MapSharedFolder" -Target "OU=Students,DC=DC300151492-00,DC=local"`                             |
| Vérifier les partages SMB              | `Get-SmbShare`                                                                                                     |

---

## 💡 Points d'apprentissage

* Administration d'Active Directory via PowerShell
* Création et gestion centralisée des objets AD (utilisateurs, groupes, OU)
* Déploiement automatisé des ressources via GPO
* Sécurisation des accès avec les groupes et RDP
* **Compréhension des droits Windows (User Rights Assignment)**
* **Utilisation de secedit pour modifier les stratégies de sécurité**
* Résolution de problèmes d'accès RDP sur Domain Controller

---

## 📁 Structure du dépôt
```
300151492/
├── README.md
├── bootstrap.ps1
├── utilisateurs1.ps1
├── utilisateurs2.ps1
├── rdp-config.ps1
├── images/
│   └── .gitkeep
```

---

## 🧾 Conclusion

Ce laboratoire m'a permis de maîtriser la gestion des objets Active Directory et l'automatisation des tâches administratives via PowerShell et GPO.

**Points clés appris :**
1. La différence entre être membre du groupe "Remote Desktop Users" et avoir le droit "SeRemoteInteractiveLogonRight"
2. Sur un Domain Controller, les deux sont nécessaires pour permettre l'accès RDP à un groupe personnalisé
3. L'utilisation de `secedit` pour modifier les droits utilisateurs (User Rights Assignment)
4. L'importance de vérifier les SID lors de la configuration des droits de sécurité

J'ai pu mettre en pratique la création d'un partage réseau, la configuration de stratégies de groupe et l'accès distant (RDP) en environnement de domaine, tout en résolvant un problème complexe de permissions RDP.
