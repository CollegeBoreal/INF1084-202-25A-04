# TP Active Directory - Gestion des Services
#300150205

---

Ce TP couvre la gestion et la surveillance des services Active Directory, incluant la consultation des logs, l'exportation des événements et le contrôle des services.

### 📄 **Services et Surveillance**
- Liste et vérification de l'état des services AD
- Consultation des journaux d'événements
- Exportation des logs vers des fichiers
- Arrêt et redémarrage de services AD

---

# 🚀 Étapes du laboratoire

## 🧮 Laboratoires

### **Objectifs**
* Lister les services AD et leur état
* Afficher les événements d'un service AD
* Capturer les événements d'un service AD dans un fichier
* Arrêt et redémarrage d'un service


---

## Étape 1 : Lister les services Active Directory

```powershell
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l'état d'un service spécifique
Get-Service -Name NTDS, ADWS, DFSR
```

> **Explication :**
> - `NTDS` : Active Directory Domain Services (service principal)
> - `ADWS` : Active Directory Web Services
> - `DFSR` : Distributed File System Replication
> - `kdc` : Key Distribution Center (Kerberos)
> - `Netlogon` : Authentification réseau
> - `IsmServ` : Intersite Messaging

**📝 Fichier :** `services1.ps1`

<details>
<summary>🖼️ Capture d'écran</summary>

![Étape 1 Screenshot](images/services1.PNG)

</details>

---

## Étape 2 : Afficher les événements des services AD

```powershell
# Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les logs du système
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Afficher les logs via le journal moderne (Event Viewer v2)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```

> **Note :**
> - `Get-EventLog` : Méthode classique pour consulter les journaux
> - `Get-WinEvent` : Méthode moderne recommandée pour Windows Server
> - Le journal "Directory Service" contient les événements spécifiques à AD DS

**📝 Fichier :** `services2.ps1`

<details>
<summary>🖼️ Capture d'écran</summary>

![Étape 2 Screenshot](images/services2.PNG)

</details>

---

## Étape 3 : Exporter les événements vers un fichier

```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
```

> **Explication :**
> - `-MaxEvents 50` : Limite l'exportation aux 50 derniers événements
> - `-NoTypeInformation` : Évite d'ajouter des métadonnées au fichier CSV
> - Le fichier CSV peut être ouvert dans Excel ou analysé avec d'autres outils

**📝 Fichier :** `services3.ps1`

<details>
<summary>🖼️ Capture d'écran</summary>

![Étape 3 Screenshot](images/services3.PNG)

</details>

---

## Étape 4 : Arrêter et redémarrer un service

```powershell
# Arrêter le service DFSR
Stop-Service -Name DFSR

# Vérifier l'état du service
(Get-Service -Name DFSR).Status

# Redémarrer le service
Start-Service -Name DFSR
```

> **⚠️ Attention :**
> - L'arrêt de services critiques comme NTDS peut rendre le contrôleur de domaine indisponible
> - DFSR est utilisé pour ce test car son arrêt temporaire a un impact limité
> - Toujours vérifier l'état du service après une opération

**📝 Fichier :** `services4.ps1`

<details>
<summary>🖼️ Capture d'écran</summary>

![Étape 4 Screenshot](images/services4.PNG)

</details>

---

## 📊 Résumé des services AD critiques

| Service | Nom technique | Rôle |
|---------|--------------|------|
| **Active Directory Domain Services** | NTDS | Service principal du contrôleur de domaine |
| **Active Directory Web Services** | ADWS | Interface PowerShell et API REST pour AD |
| **DFS Replication** | DFSR | Réplication des fichiers SYSVOL |
| **Kerberos Key Distribution Center** | kdc | Authentification Kerberos |
| **Netlogon** | Netlogon | Authentification des utilisateurs et ordinateurs |
| **Intersite Messaging** | IsmServ | Communication entre sites AD |
```

