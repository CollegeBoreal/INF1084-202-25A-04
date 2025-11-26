# 🔧 TP Active Directory - Gestion des Services
**Lounas Allouti - #300150295**

---

## 📋 Vue d'ensemble

Ce laboratoire pratique couvre la gestion complète et la surveillance des services Active Directory, incluant :

- 📊 Consultation et analyse des journaux d'événements
- 💾 Exportation des événements système
- ⚙️ Contrôle et gestion des services critiques
- 🔍 Monitoring de l'état des services AD

---

## 🎯 Objectifs d'apprentissage

* ✅ Identifier et lister les services Active Directory essentiels
* ✅ Consulter les journaux d'événements des services AD
* ✅ Exporter les logs vers des fichiers pour analyse
* ✅ Maîtriser l'arrêt et le redémarrage sécurisé des services

---

## 📝 Étape 1 : Inventaire des Services Active Directory

### Commandes PowerShell

```powershell
# Lister tous les services liés à Active Directory
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l'état des services critiques
Get-Service -Name NTDS, ADWS, DFSR
```

### 💡 Services AD essentiels

| Acronyme | Nom complet | Fonction |
|----------|-------------|----------|
| **NTDS** | Active Directory Domain Services | Cœur du contrôleur de domaine |
| **ADWS** | Active Directory Web Services | API PowerShell et REST pour AD |
| **DFSR** | Distributed File System Replication | Réplication SYSVOL entre DCs |
| **KDC** | Key Distribution Center | Gestion des tickets Kerberos |
| **Netlogon** | Netlogon | Authentification réseau des comptes |
| **IsmServ** | Intersite Messaging | Communication inter-sites |

**📂 Fichier de script :** `services1.ps1`



</details>

---

## 📊 Étape 2 : Consultation des Journaux d'Événements

### Méthodes de consultation

```powershell
# Méthode classique : Afficher les 20 derniers événements Directory Service
Get-EventLog -LogName "Directory Service" -Newest 20

# Filtrer les événements Netlogon dans le journal Système
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Méthode moderne : Utiliser Get-WinEvent (recommandé)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | 
    Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```

### 📌 Points importants

- **Get-EventLog** : Méthode traditionnelle (Windows classique)
- **Get-WinEvent** : Approche moderne et plus performante
- **Journal "Directory Service"** : Contient tous les événements AD DS
- **Journal "System"** : Événements système incluant Netlogon

**📂 Fichier de script :** `services2.ps1`



</details>

---

## 💾 Étape 3 : Exportation des Événements

### Export vers fichier CSV

```powershell
# Créer le répertoire de logs si nécessaire
New-Item -Path "C:\Logs" -ItemType Directory -Force

# Exporter les 50 derniers événements AD vers CSV
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | 
    Export-Csv -Path "C:\Logs\ADLogs_300150295.csv" -NoTypeInformation

# Vérifier l'export
Get-Content "C:\Logs\ADLogs_300150295.csv" | Select-Object -First 5
```

### 🔍 Détails de la commande

- **-MaxEvents 50** : Limite l'extraction aux 50 événements les plus récents
- **-NoTypeInformation** : Supprime les métadonnées .NET du CSV
- **Export-Csv** : Format compatible Excel et outils d'analyse
- Le fichier peut être analysé avec PowerShell, Excel ou des outils de monitoring

**📂 Fichier de script :** `services3.ps1`



</details>

---

## ⚙️ Étape 4 : Gestion du Cycle de Vie des Services

### Arrêt et redémarrage contrôlé

```powershell
# Arrêter le service DFSR (test sécurisé)
Stop-Service -Name DFSR -Force

# Vérifier l'état actuel
$serviceStatus = (Get-Service -Name DFSR).Status
Write-Host "État du service DFSR : $serviceStatus" -ForegroundColor Yellow

# Redémarrer le service
Start-Service -Name DFSR

# Confirmation du redémarrage
Get-Service -Name DFSR | Format-List Name, Status, StartType
```

### ⚠️ Avertissements de sécurité

> **ATTENTION CRITIQUE :**
> - ❌ **NE JAMAIS arrêter NTDS** sur un DC en production (rend le domaine indisponible)
> - ✅ **DFSR** peut être arrêté temporairement sans impact majeur
> - 🔒 **Netlogon** et **KDC** sont essentiels pour l'authentification
> - 📝 Toujours documenter les opérations de maintenance
> - ✔️ Vérifier systématiquement l'état après chaque opération

**📂 Fichier de script :** `services4.ps1`





</details>

---

## 📊 Tableau Récapitulatif des Services AD

| Service | Nom Technique | Criticité | Impact si arrêté | Redémarrage sécurisé |
|---------|---------------|-----------|------------------|---------------------|
| **Active Directory Domain Services** | NTDS | 🔴 Critique | DC hors ligne | ❌ Non recommandé |
| **Active Directory Web Services** | ADWS | 🟡 Important | PowerShell AD indisponible | ✅ Oui |
| **DFS Replication** | DFSR | 🟡 Important | Réplication SYSVOL suspendue | ✅ Oui |
| **Kerberos KDC** | kdc | 🔴 Critique | Authentification impossible | ❌ Non recommandé |
| **Netlogon** | Netlogon | 🔴 Critique | Connexions bloquées | ❌ Non recommandé |
| **Intersite Messaging** | IsmServ | 🟢 Modéré | Communication inter-sites ralentie | ✅ Oui |

---

## ✅ Validation et Vérification

### Script de vérification globale

```powershell
# Vérifier tous les services AD critiques
$criticalServices = @("NTDS", "ADWS", "DFSR", "kdc", "Netlogon")

foreach ($service in $criticalServices) {
    $status = (Get-Service -Name $service -ErrorAction SilentlyContinue).Status
    if ($status -eq "Running") {
        Write-Host "✓ $service : En cours d'exécution" -ForegroundColor Green
    } else {
        Write-Host "✗ $service : $status" -ForegroundColor Red
    }
}
```

---



---

**🎓 Travail réalisé par :** Lounas Allouti  
**📋 Numéro d'étudiant :** 300150295  
