# TP Active Directory - Gestion des Services
**#300151492**

Salut! Ce TP gérer les services Active Directory. On va regarder les logs, exporter des données et contrôler les services.

---

## 📄 Ce qu'on va faire

- Voir quels services AD tournent sur notre serveur
- Consulter les logs pour comprendre ce qui se passe
- Exporter les événements dans un fichier
- Arrêter et redémarrer un service (sans tout casser!)

---

## 🚀 Les 4 étapes du TP

### Ce qu'on doit accomplir
- Faire la liste des services AD
- Regarder les événements d'un service
- Sauvegarder les événements dans un fichier CSV
- Tester l'arrêt et le redémarrage d'un service

---

## Étape 1 : Voir tous les services Active Directory

```powershell
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l'état d'un service spécifique
Get-Service -Name NTDS, ADWS, DFSR
```

**C'est quoi tout ça?**
- `NTDS` : Le cerveau d'Active Directory
- `ADWS` : Pour gérer AD à distance
- `DFSR` : Synchronise les fichiers entre serveurs
- `kdc` : Gère l'authentification Kerberos
- `Netlogon` : Permet aux utilisateurs de se connecter
- `IsmServ` : Communication entre différents sites


## Étape 2 : Regarder ce qui se passe dans les logs

```powershell
# Les 20 derniers événements d'AD
Get-EventLog -LogName "Directory Service" -Newest 20

# Les logs système pour Netlogon
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Version moderne des logs
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```

**Petite note :**
- `Get-EventLog` : L'ancienne façon de voir les logs
- `Get-WinEvent` : La nouvelle méthode (plus rapide!)
- "Directory Service" contient tout ce qui concerne AD

📝 **Fichier à créer :** `services2.ps1`

![Étape 1 Screenshot](images/services1.PNG)

---

## Étape 3 : Sauvegarder les logs dans Excel

```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
```

**Pourquoi c'est cool?**
- On garde les 50 derniers événements
- Le fichier s'ouvre directement dans Excel
- Super pratique pour analyser les problèmes plus tard

📝 **Fichier à créer :** `services3.ps1`

![Étape 1 Screenshot](images/services1.PNG)

---

## Étape 4 : Arrêter puis redémarrer un service

```powershell
# Arrêter le service DFSR
Stop-Service -Name DFSR

# Vérifier qu'il est bien arrêté
(Get-Service -Name DFSR).Status

# Le redémarrer
Start-Service -Name DFSR
```

⚠️ **ATTENTION - Lis bien ça!**
- Ne JAMAIS arrêter NTDS (ça casse tout!)
- DFSR, c'est safe pour tester
- Toujours vérifier que le service redémarre bien

📝 **Fichier à créer :** `services4.ps1`

![Étape 1 Screenshot](images/services1.PNG)

---

## 📊 Les services importants à retenir

| Service | Nom court | Ce qu'il fait |
|---------|-----------|---------------|
| Active Directory Domain Services | NTDS | Le boss - gère tout AD |
| Active Directory Web Services | ADWS | Pour utiliser PowerShell à distance |
| DFS Replication | DFSR | Copie les fichiers entre serveurs |
| Kerberos Key Distribution Center | kdc | Vérifie qui tu es (authentification) |
| Netlogon | Netlogon | Te connecte au domaine |
| Intersite Messaging | IsmServ | Fait parler les différents sites entre eux |

---
