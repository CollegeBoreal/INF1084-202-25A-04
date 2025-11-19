## 📋 Table des matières

- [Objectifs du TP](#objectifs-du-tp)
- [Prérequis](#prérequis)
- [Services Active Directory](#services-active-directory)
- [Laboratoire 1 : Lister les services AD](#laboratoire-1--lister-les-services-ad-et-leur-état)
- [Laboratoire 2 : Consulter les journaux](#laboratoire-2--afficher-les-événements-dun-service-ad)
- [Laboratoire 3 : Exporter les logs](#laboratoire-3--capturer-les-événements-dans-un-fichier)
- [Laboratoire 4 : Arrêt et redémarrage](#laboratoire-4--arrêt-et-redémarrage-dun-service)
- [Surveillance avancée](#surveillance-avancée)
- [Dépannage](#dépannage)
- [Bonnes pratiques](#bonnes-pratiques)

---

## 🎯 Objectifs du TP

À la fin de ce laboratoire, vous serez capable de :

- ✅ Lister les services Active Directory et vérifier leur état
- ✅ Consulter les journaux d'événements des services AD
- ✅ Exporter les logs vers des fichiers pour analyse
- ✅ Arrêter et redémarrer des services AD en toute sécurité
- ✅ Surveiller la santé des services critiques

---

## 📦 Prérequis

- Windows Server 2022 avec rôle AD DS installé
- Contrôleur de domaine configuré et opérationnel
- PowerShell ouvert en tant qu'**Administrateur**
- Droits d'administration sur le domaine
- Environ 30-45 minutes pour compléter tous les laboratoires

---

## 🔍 Services Active Directory

### Services critiques AD

| Service | Nom du service | Description |
|---------|----------------|-------------|
| **NTDS** | `NTDS` | Active Directory Domain Services (service principal) |
| **DNS** | `DNS` | Serveur DNS pour la résolution de noms |
| **Kerberos** | `KDC` | Key Distribution Center (authentification) |
| **Netlogon** | `Netlogon` | Gestion des connexions au domaine |
| **DFS** | `DFS` | Distributed File System |
| **FRS** | `NTFRS` | File Replication Service (ancien) |
| **DFSR** | `DFSR` | DFS Replication (nouveau) |
| **W32Time** | `W32Time` | Service de temps Windows |

> ⚠️ **Attention** : L'arrêt de certains services peut rendre le contrôleur de domaine non fonctionnel.

---

## 📁 Scripts PowerShell

Ce laboratoire inclut 4 scripts PowerShell prêts à l'emploi :

| Script | Description | Laboratoire |
|--------|-------------|-------------|
| `services1.ps1` | Liste et vérifie l'état des services AD | Lab 1 |
| `services2.ps1` | Affiche les événements des journaux AD | Lab 2 |
| `services3.ps1` | Exporte les logs vers des fichiers | Lab 3 |
| `services4.ps1` | Gestion de l'arrêt/redémarrage des services | Lab 4 |

### 📥 Téléchargement et utilisation

```powershell
# Télécharger les scripts (si hébergés sur GitHub)
git clone https://github.com/votre-repo/ad-services-lab.git
cd ad-services-lab

# Ou créer les fichiers manuellement (voir ci-dessous)
```

### 🎬 Exemples de sortie

#### Laboratoire 1 - Liste des services
```
=============================================
  LAB 1 - LISTE DES SERVICES AD
  Lab #300150205
=============================================

[1] Services Active Directory détectés :
─────────────────────────────────────────────

Name  Status  StartType DisplayName
----  ------  --------- -----------
NTDS  Running Automatic Active Directory Domain Services
ADWS  Running Automatic Active Directory Web Services

[2] État des services critiques AD :
─────────────────────────────────────────────
✓ Active Directory Domain Services          [Running] (Automatic)
✓ Serveur DNS                               [Running] (Automatic)
✓ Centre de distribution de clés Kerberos   [Running] (Automatic)
✓ Netlogon                                  [Running] (Automatic)
✓ Service de Temps Windows                  [Running] (Automatic)
✓ Active Directory Web Services             [Running] (Automatic)

[3] Résumé :
─────────────────────────────────────────────
Services en cours d'exécution : 6
Services arrêtés              : 0

✓ Tous les services AD sont opérationnels !
```

#### Laboratoire 2 - Journaux d'événements
```
=============================================
  LAB 2 - JOURNAUX D'ÉVÉNEMENTS AD
  Lab #300150205
=============================================

Sélectionnez une option :
  [1] Événements Directory Service (AD DS)
  [2] Événements DNS Server
  [3] Événements System (Services)
  [4] Erreurs uniquement (tous les journaux)
  [5] Recherche par EventID
  [6] Événements des dernières 24h
  [7] Tous les événements critiques
  [0] Quitter

Votre choix: 1

[Directory Service] - 20 derniers événements
─────────────────────────────────────────────────────────
[2025-11-18 14:23:15] Information ID:1000 - The Active Directory Domain Services ...
[2025-11-18 14:20:32] Information ID:2889 - LDAP bind completed successfully...
[2025-11-18 14:15:08] Warning ID:1644 - Expensive LDAP search detected...

Total : 20 événements affichés
```

#### Laboratoire 3 - Export des logs
```
═══════════════════════════════════════════
  OPTIONS D'EXPORT
═══════════════════════════════════════════

  [1] Export complet (tous les journaux)
  [2] Export Directory Service uniquement
  [3] Export DNS Server uniquement
  [4] Export erreurs uniquement (CSV)
  [5] Export personnalisé (choix du nombre d'événements)
  [6] Export au format texte lisible
  [7] Export des événements critiques
  [0] Quitter

Votre choix: 1

[EXPORT COMPLET] Tous les journaux AD
─────────────────────────────────────────────

  → Récupération de 1000 événements de [Directory Service]...
  ✓ Export réussi : 245.67 KB
  → Récupération de 1000 événements de [DNS Server]...
  ✓ Export réussi : 189.23 KB
  → Récupération de 1000 événements de [System]...
  ✓ Export réussi : 312.45 KB

Export terminé : 3/3 journaux exportés

═══════════════════════════════════════════
  RÉSUMÉ DE L'EXPORT
═══════════════════════════════════════════

📁 Emplacement : C:\ADLogs\Export_20251118_143000
📊 Nombre de fichiers : 3
💾 Taille totale : 747.35 KB

Fichiers créés :
  • DirectoryService_20251118_143000.csv (245.67 KB)
  • DNSServer_20251118_143000.csv (189.23 KB)
  • System_20251118_143000.csv (312.45 KB)

✓ Export terminé avec succès !
```

#### Laboratoire 4 - Gestion des services
```
════════════════════════════════════════════════════
  LAB 4 - GESTION DES SERVICES AD
  Lab #300150205
════════════════════════════════════════════════════

⚠  AVERTISSEMENT : Impact sur le domaine possible

═══════════════════════════════════════════
  MENU PRINCIPAL
═══════════════════════════════════════════

  [1] Afficher l'état des services
  [2] Arrêter un service
  [3] Démarrer un service
  [4] Redémarrer un service
  [5] Surveillance en temps réel
  [6] Rapport complet
  [0] Quitter

Votre choix: 5

═══════════════════════════════════════════
  SURVEILLANCE DES SERVICES AD
═══════════════════════════════════════════
Actualisation : 14:30:15 | Cycle #12

✓ Active Directory Web Services           [Running]
✓ Service de Temps Windows                [Running]
✓ Serveur DNS                             [Running]
✓ Active Directory Domain Services        [Running]
✓ Netlogon                                [Running]
✓ Centre de distribution de clés Kerberos [Running]

Appuyez sur Ctrl+C pour quitter...
```

---

### 📥 Téléchargement et utilisation

---

el*

---

## 🧪 Laboratoire 1 : Lister les services AD et leur état

### Objectif
Identifier et vérifier l'état de tous les services Active Directory critiques.

### 📄 Script : `services1.ps1`

Créez le fichier `services1.ps1` avec le contenu fourni dans le dépôt, ou utilisez les commandes ci-dessous directement.

### Commandes PowerShell

#### 1.1 Lister tous les services AD

```powershell
# Lister les services liés à Active Directory
Get-Service | Where-Object {$_.DisplayName -like "*Active Directory*"}
```

**Résultat attendu :**
```
Status   Name               DisplayName
------   ----               -----------
Running  NTDS               Active Directory Domain Services
Running  ADWS               Active Directory Web Services
Running  DFS                Distributed File System
```

#### 1.2 Vérifier les services critiques spécifiques

```powershell
# Liste des services critiques AD
$ADServices = @("NTDS", "DNS", "KDC", "Netlogon", "W32Time", "ADWS")

Get-Service $ADServices | Format-Table Name, Status, StartType, DisplayName -AutoSize
```

#### 1.3 Afficher uniquement les services en cours d'exécution

```powershell
Get-Service $ADServices | Where-Object {$_.Status -eq "Running"}
```

#### 1.4 Afficher les services arrêtés ou avec des problèmes

```powershell
Get-Service $ADServices | Where-Object {$_.Status -ne "Running"} | 
    Format-Table Name, Status, DisplayName -AutoSize
```

### ✅ Vérification

Tous les services critiques doivent être dans l'état **Running**.

---

## 📊 Laboratoire 2 : Afficher les événements d'un service AD

### Objectif
Consulter les journaux d'événements pour surveiller et diagnostiquer les services AD.

### Journaux Windows

| Journal | Description |
|---------|-------------|
| **Directory Service** | Événements NTDS (AD DS) |
| **DNS Server** | Événements du serveur DNS |
| **System** | Événements système (démarrage/arrêt de services) |
| **Security** | Événements de sécurité et authentification |

### Commandes PowerShell

#### 2.1 Afficher les derniers événements du service NTDS

```powershell
# Afficher les 20 derniers événements du service AD DS
Get-EventLog -LogName "Directory Service" -Newest 20 | 
    Format-Table TimeGenerated, EntryType, Source, EventID, Message -AutoSize
```

#### 2.2 Afficher les événements du serveur DNS

```powershell
# Événements DNS récents
Get-EventLog -LogName "DNS Server" -Newest 20 | 
    Format-Table TimeGenerated, EntryType, EventID, Message -Wrap
```

#### 2.3 Filtrer les événements par type (Erreurs uniquement)

```powershell
# Afficher uniquement les erreurs du service AD DS
Get-EventLog -LogName "Directory Service" -EntryType Error -Newest 50
```

#### 2.4 Rechercher des événements spécifiques par EventID

```powershell
# Rechercher un événement spécifique (ex: EventID 1644 = recherches LDAP coûteuses)
Get-EventLog -LogName "Directory Service" | 
    Where-Object {$_.EventID -eq 1644} | 
    Select-Object TimeGenerated, Message
```

#### 2.5 Afficher les événements de démarrage/arrêt de services

```powershell
# Événements de démarrage et arrêt de services AD
Get-EventLog -LogName System -Source "Service Control Manager" -Newest 50 | 
    Where-Object {$_.Message -like "*NTDS*" -or $_.Message -like "*DNS*"} |
    Format-Table TimeGenerated, EntryType, Message -Wrap
```

### 📈 Événements importants à surveiller

| EventID | Journal | Description |
|---------|---------|-------------|
| 1168 | Directory Service | Erreur de réplication AD |
| 2087 | Directory Service | Échec de résolution DNS |
| 1644 | Directory Service | Recherches LDAP inefficaces |
| 1000 | Application | Crash d'application |
| 1001 | Application | Rapport d'erreur Windows |

---

## 💾 Laboratoire 3 : Capturer les événements dans un fichier

### Objectif
Exporter les journaux d'événements vers des fichiers pour archivage ou analyse approfondie.

### Commandes PowerShell

#### 3.1 Exporter les événements AD vers un fichier CSV

```powershell
# Créer un dossier pour les exports
New-Item -Path "C:\ADLogs" -ItemType Directory -Force

# Exporter les événements Directory Service
Get-EventLog -LogName "Directory Service" -Newest 500 | 
    Select-Object TimeGenerated, EntryType, Source, EventID, Message |
    Export-Csv -Path "C:\ADLogs\DirectoryService_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv" -NoTypeInformation

Write-Host "Export terminé : C:\ADLogs\DirectoryService_*.csv" -ForegroundColor Green
```

#### 3.2 Exporter les événements DNS

```powershell
Get-EventLog -LogName "DNS Server" -Newest 500 | 
    Select-Object TimeGenerated, EntryType, EventID, Message |
    Export-Csv -Path "C:\ADLogs\DNSServer_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv" -NoTypeInformation

Write-Host "Export DNS terminé" -ForegroundColor Green
```

#### 3.3 Exporter uniquement les erreurs et avertissements

```powershell
# Exporter seulement les erreurs et warnings
Get-EventLog -LogName "Directory Service" -EntryType Error,Warning -Newest 200 |
    Select-Object TimeGenerated, EntryType, EventID, Message |
    Export-Csv -Path "C:\ADLogs\AD_Errors_$(Get-Date -Format 'yyyyMMdd').csv" -NoTypeInformation
```

#### 3.4 Exporter vers un fichier texte lisible

```powershell
# Export formaté en texte
Get-EventLog -LogName "Directory Service" -Newest 100 | 
    Format-List TimeGenerated, EntryType, Source, EventID, Message |
    Out-File -FilePath "C:\ADLogs\AD_Events_$(Get-Date -Format 'yyyyMMdd').txt"
```

#### 3.5 Script d'export complet (tous les journaux AD)

```powershell
# Script d'export complet
$ExportPath = "C:\ADLogs\Export_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
New-Item -Path $ExportPath -ItemType Directory -Force

# Liste des journaux à exporter
$Logs = @("Directory Service", "DNS Server", "System")

foreach ($Log in $Logs) {
    $FileName = $Log.Replace(" ", "_")
    Get-EventLog -LogName $Log -Newest 1000 -ErrorAction SilentlyContinue |
        Export-Csv -Path "$ExportPath\$FileName.csv" -NoTypeInformation
    Write-Host "✓ $Log exporté" -ForegroundColor Green
}

Write-Host "`n📁 Tous les logs exportés vers : $ExportPath" -ForegroundColor Cyan
```

### 📂 Structure des exports recommandée

```
C:\ADLogs\
├── Export_20251118_143000\
│   ├── Directory_Service.csv
│   ├── DNS_Server.csv
│   └── System.csv
├── AD_Errors_20251118.csv
└── AD_Events_20251118.txt
```

---

## 🔄 Laboratoire 4 : Arrêt et redémarrage d'un service

### Objectif
Apprendre à arrêter et redémarrer les services AD en toute sécurité pour maintenance.

> ⚠️ **AVERTISSEMENT CRITIQUE** : L'arrêt de services AD peut interrompre l'authentification et l'accès aux ressources du domaine. À effectuer uniquement pendant une fenêtre de maintenance.

### Commandes PowerShell

#### 4.1 Vérifier l'état d'un service avant modification

```powershell
# Vérifier le statut du service NTDS
Get-Service NTDS | Format-List Name, Status, StartType, DisplayName
```

#### 4.2 Arrêter un service AD (exemple avec ADWS)

```powershell
# Arrêter Active Directory Web Services (non critique pour test)
Stop-Service -Name ADWS -Force -Verbose

# Vérifier l'arrêt
Get-Service ADWS
```

**Résultat attendu :**
```
Status   Name               DisplayName
------   ----               -----------
Stopped  ADWS               Active Directory Web Services
```

#### 4.3 Démarrer un service

```powershell
# Démarrer le service
Start-Service -Name ADWS -Verbose

# Vérifier le démarrage
Get-Service ADWS
```

#### 4.4 Redémarrer un service

```powershell
# Redémarrer le service DNS
Restart-Service -Name DNS -Force -Verbose

Write-Host "Service DNS redémarré avec succès" -ForegroundColor Green
```

#### 4.5 Arrêter et redémarrer plusieurs services

```powershell
# Redémarrer plusieurs services (attention : impact sur le domaine)
$ServicesToRestart = @("ADWS", "W32Time")

foreach ($Service in $ServicesToRestart) {
    Write-Host "Redémarrage de $Service..." -ForegroundColor Yellow
    Restart-Service -Name $Service -Force
    Start-Sleep -Seconds 2
    
    $Status = (Get-Service $Service).Status
    if ($Status -eq "Running") {
        Write-Host "✓ $Service : Opérationnel" -ForegroundColor Green
    } else {
        Write-Host "✗ $Service : Problème détecté!" -ForegroundColor Red
    }
}
```

#### 4.6 Script sécurisé avec confirmation

```powershell
# Script avec confirmation utilisateur
function Restart-ADService {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ServiceName
    )
    
    $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
    
    if (-not $Service) {
        Write-Host "Service $ServiceName introuvable!" -ForegroundColor Red
        return
    }
    
    Write-Host "`n⚠️  Vous êtes sur le point de redémarrer : $($Service.DisplayName)" -ForegroundColor Yellow
    $Confirm = Read-Host "Continuer? (O/N)"
    
    if ($Confirm -eq "O") {
        Write-Host "Arrêt du service..." -ForegroundColor Yellow
        Stop-Service $ServiceName -Force
        Start-Sleep -Seconds 3
        
        Write-Host "Démarrage du service..." -ForegroundColor Yellow
        Start-Service $ServiceName
        
        $NewStatus = (Get-Service $ServiceName).Status
        Write-Host "✓ Statut actuel : $NewStatus" -ForegroundColor Green
    } else {
        Write-Host "Opération annulée." -ForegroundColor Gray
    }
}

# Utilisation
Restart-ADService -ServiceName "ADWS"
```

### ⚠️ Services critiques - Précautions

| Service | Impact si arrêté | Redémarrage sûr ? |
|---------|------------------|-------------------|
| **NTDS** | ❌ Domaine inaccessible | ⚠️ Seulement en maintenance |
| **DNS** | ⚠️ Résolution de noms impossible | ✅ Oui (rapide) |
| **Netlogon** | ❌ Authentification impossible | ⚠️ Seulement en maintenance |
| **KDC** | ❌ Kerberos non fonctionnel | ⚠️ Seulement en maintenance |
| **ADWS** | ⚠️ PowerShell AD cmdlets indisponibles | ✅ Oui |
| **W32Time** | ⚠️ Synchronisation temps affectée | ✅ Oui |

---

## 📡 Surveillance avancée

### Script de surveillance en temps réel

```powershell
# Surveillance continue des services AD
function Monitor-ADServices {
    $Services = @("NTDS", "DNS", "KDC", "Netlogon", "ADWS")
    
    while ($true) {
        Clear-Host
        Write-Host "=== Surveillance des Services AD ===" -ForegroundColor Cyan
        Write-Host "Actualisation : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`n" -ForegroundColor Gray
        
        foreach ($Service in $Services) {
            $Status = (Get-Service $Service).Status
            $Color = if ($Status -eq "Running") { "Green" } else { "Red" }
            
            Write-Host "$Service : " -NoNewline
            Write-Host "$Status" -ForegroundColor $Color
        }
        
        Write-Host "`nAppuyez sur Ctrl+C pour arrêter..." -ForegroundColor Gray
        Start-Sleep -Seconds 5
    }
}

# Lancer la surveillance
Monitor-ADServices
```

### Créer une alerte sur arrêt de service

```powershell
# Script d'alerte par email (nécessite configuration SMTP)
$Service = "NTDS"
$Status = (Get-Service $Service).Status

if ($Status -ne "Running") {
    $Body = "ALERTE : Le service $Service est $Status sur $(hostname)"
    
    # Configuration email (adapter selon votre environnement)
    Send-MailMessage -From "ad-alerts@domain.local" `
                     -To "admin@domain.local" `
                     -Subject "⚠️ Alerte Service AD" `
                     -Body $Body `
                     -SmtpServer "smtp.domain.local"
}
```

---

## 🔧 Dépannage

### Problème : Service ne démarre pas

```powershell
# Vérifier les dépendances du service
Get-Service NTDS | Select-Object -ExpandProperty DependentServices
Get-Service NTDS | Select-Object -ExpandProperty ServicesDependedOn

# Vérifier les erreurs dans les journaux
Get-EventLog -LogName System -Source "Service Control Manager" -Newest 20 |
    Where-Object {$_.EntryType -eq "Error"}
```

### Problème : Service se bloque lors de l'arrêt

```powershell
# Forcer l'arrêt d'un service récalcitrant
Stop-Service -Name ADWS -Force -NoWait

# Si nécessaire, terminer le processus
$Service = Get-WmiObject -Class Win32_Service -Filter "Name='ADWS'"
Stop-Process -Id $Service.ProcessId -Force
```

### Vérifier l'intégrité de la base AD

```powershell
# Vérifier l'état de la base NTDS
dcdiag /test:services
dcdiag /test:replications

# Vérifier la réplication AD
repadmin /showrepl
```

---

## ✅ Bonnes pratiques

### 🛡️ Sécurité et maintenance

1. **Planification**
   - Toujours effectuer les opérations pendant une fenêtre de maintenance
   - Notifier les utilisateurs avant toute intervention

2. **Sauvegarde**
   - Effectuer une sauvegarde système avant toute modification
   - Sauvegarder l'état du système : `wbadmin start systemstatebackup -backuptarget:E:`

3. **Documentation**
   - Documenter toutes les interventions
   - Exporter les logs avant et après chaque opération

4. **Test**
   - Tester d'abord sur un contrôleur de domaine secondaire
   - Vérifier la réplication après redémarrage

5. **Surveillance**
   - Mettre en place une surveillance automatisée
   - Configurer des alertes pour les services critiques

### 📋 Checklist avant redémarrage

- [ ] Vérifier qu'il existe d'autres contrôleurs de domaine disponibles
- [ ] Notifier les utilisateurs
- [ ] Sauvegarder l'état du système
- [ ] Exporter les logs actuels
- [ ] Documenter la raison de l'intervention
- [ ] Planifier une fenêtre de maintenance
- [ ] Préparer un plan de rollback

---

## 📚 Références

- [Microsoft Docs - AD DS Services](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/manage/component-updates/ad-ds-operations)
- [PowerShell Service Management](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service)
- [Event Log Management](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog)
- [AD Troubleshooting](https://docs.microsoft.com/en-us/troubleshoot/windows-server/identity/active-directory-replication-event-id-1988-1990)

---

## 📝 Notes de laboratoire

**Étudiant :** #300150205  
**Date :** _________________  
**Durée du TP :** ~45 minutes  
**Résultat :** ⭐⭐⭐⭐⭐

### Validation des compétences

- [ ] Lister et vérifier l'état des services AD
- [ ] Consulter les journaux d'événements
- [ ] Exporter les logs vers des fichiers
- [ ] Arrêter et redémarrer des services en toute sécurité
- [ ] Surveiller la santé des services critiques

---

**Dernière mise à jour :** Novembre 2025  
**Version :** 1.0  
**Lab ID :** 300150205
