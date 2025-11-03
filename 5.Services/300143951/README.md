# 🧮 Laboratoire - Gestion des Services Active Directory

## 📋 Table des matières
- [Objectifs](#-objectifs)
- [Prérequis](#-prérequis)
- [Structure du projet](#-structure-du-projet)
- [Scripts PowerShell](#-scripts-powershell)
  - [services1.ps1 - Liste des services AD](#services1ps1---liste-des-services-ad)
  - [services2.ps1 - Consultation des événements](#services2ps1---consultation-des-événements)
  - [services3.ps1 - Export des logs](#services3ps1---export-des-logs)
  - [services4.ps1 - Gestion des services](#services4ps1---gestion-des-services)
- [Utilisation](#-utilisation)
- [Résultats attendus](#-résultats-attendus)
- [Dépannage](#-dépannage)
- [Auteur](#-auteur)

---

## 🎯 Objectifs

Ce laboratoire a pour but de maîtriser la gestion des services Active Directory via PowerShell :

1. ✅ Lister les services AD et leur état
2. ✅ Afficher les événements d'un service AD
3. ✅ Capturer les événements d'un service AD dans un fichier
4. ✅ Arrêter et redémarrer un service

---

## 🔧 Prérequis

- **Système d'exploitation** : Windows Server 2016/2019/2022
- **Rôle** : Contrôleur de domaine Active Directory
- **Droits** : Administrateur du domaine
- **PowerShell** : Version 5.1 ou supérieure

### Vérification des prérequis

```powershell
# Vérifier la version PowerShell
$PSVersionTable.PSVersion

# Vérifier si le serveur est un DC
Get-ADDomainController

# Vérifier les droits administrateur
[Security.Principal.WindowsIdentity]::GetCurrent().Groups | 
    Where-Object {$_.Value -eq 'S-1-5-32-544'}
```

---

## 📁 Structure du projet

```
INF1084-202-25A-03/
│
├── README.md                 # Ce fichier
├── services1.ps1            # Liste des services AD
├── services2.ps1            # Affichage des événements
├── services3.ps1            # Export des logs
├── services4.ps1            # Gestion des services
└── C:\Logs\                 # Dossier de sortie des logs (créé automatiquement)
```

---

## 📜 Scripts PowerShell

### services1.ps1 - Liste des services AD

**Description** : Liste tous les services liés à Active Directory et vérifie leur état.

**Code** :
```powershell
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l'état d'un service spécifique
Get-Service -Name NTDS, ADWS, DFSR
```

**Services surveillés** :
- **NTDS** : Active Directory Domain Services
- **ADWS** : Active Directory Web Services
- **DFSR** : DFS Replication
- **kdc** : Kerberos Key Distribution Center
- **Netlogon** : Net Logon
- **IsmServ** : Intersite Messaging

**Exemple de sortie** :
```
Status   Name               DisplayName
------   ----               -----------
Running  ADWS               Active Directory Web Services
Running  DFSR               DFS Replication
Running  Netlogon           Netlogon
Running  NTDS               Active Directory Domain Services
```

---

### services2.ps1 - Consultation des événements

**Description** : Affiche les derniers événements des journaux Active Directory.

**Code** :
```powershell
# Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les logs du système
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Afficher les logs via le journal moderne (Event Viewer v2)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | 
    Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```

**Types d'événements** :
- **Information** : Opérations normales
- **Avertissement** : Problèmes potentiels
- **Erreur** : Erreurs nécessitant attention
- **Critique** : Défaillances graves

**Exemple de sortie** :
```
TimeCreated           Id LevelDisplayName Message
-----------           -- ---------------- -------
2025-10-30 09:15:23 1000 Information      Active Directory Domain Services startup complete
2025-10-30 09:14:55 2087 Information      LDAP over SSL connection established
```

---

### services3.ps1 - Export des logs

**Description** : Capture et exporte les événements AD dans un fichier CSV pour analyse ultérieure.

**Code** :
```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | 
    Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
```

**Amélioration recommandée** :
```powershell
# Créer le dossier s'il n'existe pas
$logPath = "C:\Logs"
if (-not (Test-Path $logPath)) {
    New-Item -Path $logPath -ItemType Directory
}

# Exporter avec timestamp
$date = Get-Date -Format "yyyyMMdd_HHmmss"
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | 
    Select-Object TimeCreated, Id, LevelDisplayName, Message |
    Export-Csv -Path "C:\Logs\ADLogs_$date.csv" -NoTypeInformation

Write-Host "Logs exportés vers C:\Logs\ADLogs_$date.csv" -ForegroundColor Green
```

**Fichier généré** : `C:\Logs\ADLogs_20251030_093927.csv`

---

### services4.ps1 - Gestion des services

**Description** : Démontre l'arrêt et le redémarrage d'un service AD (DFS Replication).

**Code** :
```powershell
Stop-Service -Name DFSR
(Get-Service -name DFSR).status
Start-Service -Name DFSR
```

**Version améliorée avec gestion d'erreurs** :
```powershell
# Vérifier les droits admin
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Ce script nécessite des droits administrateur !"
    exit
}

# Arrêter le service
Write-Host "Arrêt du service DFSR..." -ForegroundColor Yellow
Stop-Service -Name DFSR -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Vérifier l'état
$status = (Get-Service -Name DFSR).Status
Write-Host "État du service: $status" -ForegroundColor Cyan

# Redémarrer
Write-Host "Démarrage du service DFSR..." -ForegroundColor Yellow
Start-Service -Name DFSR

# Vérifier le nouveau statut
$newStatus = (Get-Service -Name DFSR).Status
Write-Host "Nouveau statut: $newStatus" -ForegroundColor Green
```

**⚠️ Avertissement** : N'arrêtez JAMAIS le service NTDS sur un contrôleur de domaine en production !

---

## 🚀 Utilisation

### Exécution individuelle

1. **Ouvrir PowerShell en tant qu'administrateur**
   ```powershell
   Start-Process powershell -Verb RunAs
   ```

2. **Naviguer vers le dossier du projet**
   ```powershell
   cd C:\Users\Administrator\Developer\INF1084-202-25A-03
   ```

3. **Exécuter un script**
   ```powershell
   .\services1.ps1
   ```

### Exécution de tous les scripts

```powershell
# Exécuter tous les scripts dans l'ordre
Get-ChildItem -Filter "services*.ps1" | Sort-Object Name | ForEach-Object {
    Write-Host "`n=== Exécution de $($_.Name) ===" -ForegroundColor Cyan
    & $_.FullName
    Write-Host "=== Fin de $($_.Name) ===`n" -ForegroundColor Green
}
```

---

## ✅ Résultats attendus

### Script 1 - Liste des services
- Affichage de tous les services AD
- État : Running/Stopped
- Type de démarrage : Automatic/Manual

### Script 2 - Événements
- Liste des 20 derniers événements
- Horodatage, ID d'événement, niveau, message
- Filtrage par source Netlogon

### Script 3 - Export
- Création du fichier CSV
- 50 événements exportés
- Fichier accessible dans `C:\Logs\`

### Script 4 - Gestion
- Service DFSR arrêté avec succès
- Statut vérifié : Stopped
- Service redémarré : Running

---

## 🔍 Dépannage

### Erreur : "Accès refusé"
**Solution** : Exécuter PowerShell en tant qu'administrateur
```powershell
Start-Process powershell -Verb RunAs
```

### Erreur : "Le service n'existe pas"
**Solution** : Vérifier que vous êtes sur un contrôleur de domaine
```powershell
Get-Service -Name NTDS
```

### Erreur : "Impossible de créer le fichier"
**Solution** : Créer le dossier manuellement
```powershell
New-Item -Path "C:\Logs" -ItemType Directory -Force
```

### Les événements sont vides
**Solution** : Utiliser `Get-WinEvent` au lieu de `Get-EventLog`
```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 20
```

---

## 📊 Commandes utiles supplémentaires

### Vérifier la santé du domaine
```powershell
# Test de réplication
repadmin /replsummary

# Diagnostic du contrôleur de domaine
dcdiag /v

# Vérifier les rôles FSMO
netdom query fsmo
```

### Monitoring en temps réel
```powershell
# Surveiller un service en continu
while ($true) {
    Clear-Host
    Get-Service -Name NTDS, ADWS, DFSR, Netlogon | Format-Table -AutoSize
    Start-Sleep -Seconds 5
}
```

---

## 📝 Notes importantes

1. **Sauvegarde** : Toujours sauvegarder avant de modifier des services critiques
2. **Test** : Tester dans un environnement de développement d'abord
3. **Documentation** : Documenter toute modification apportée
4. **Monitoring** : Surveiller les logs après chaque intervention

---

## 📚 Références

- [Documentation Microsoft - Active Directory](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/)
- [PowerShell Module - ActiveDirectory](https://docs.microsoft.com/en-us/powershell/module/activedirectory/)
- [Get-Service Documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service)
- [Get-WinEvent Documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-winevent)

---

## 👤 Auteur

**Cours** : INF1084-202-25A-03  
**Institution** : Collège Boréal  
**Session** : Automne 2025  
**Date** : 30 octobre 2025

---

## 📄 Licence

Ce projet est réalisé dans un cadre pédagogique pour le cours INF1084.

---

**🎓 Bon laboratoire !**
