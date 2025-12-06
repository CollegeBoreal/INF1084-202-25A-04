Services1.ps1
# Gestion des Services Active Directory avec PowerShell

Ce projet permet de **lister, surveiller, exporter et contrôler les services Active Directory (AD)** à l'aide de scripts PowerShell.  
Chaque script correspond à une tâche spécifique dans l’administration des services AD et la gestion des journaux.

---

## 1. Liste des scripts

| Script | Fonction |
|--------|----------|
| `services1.ps1` | Lister tous les services liés à AD et vérifier l’état de services spécifiques |
| `services2.ps1` | Afficher les événements récents liés à AD et Netlogon |
| `services3.ps1` | Exporter les événements AD dans un fichier CSV |
| `services4.ps1` | Arrêter et redémarrer un service AD spécifique |

---

## 2. Détails des scripts et captures d’écran

### 2.1 `services1.ps1` – Liste des services AD

Ce script permet de lister tous les services liés à Active Directory et de vérifier l’état des services clés comme **NTDS, ADWS et DFSR**.

```powershell
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l’état d’un service spécifique
Get-Service -Name NTDS, ADWS, DFSR



<img width="799" height="254" alt="s1" src="https://github.com/user-attachments/assets/4a228a64-7277-4ade-a2f7-1d5332f6a0e2" />

###Services2.ps1

<img width="1012" height="391" alt="s2" src="https://github.com/user-attachments/assets/35d0369a-11f6-4bd5-8c26-ebde52d07bbe" />

Services3.ps1

<img width="772" height="85" alt="s3" src="https://github.com/user-attachments/assets/df00c8bf-ff7c-4711-9845-899e83d4280c" />

Services4.ps1

<img width="858" height="100" alt="s4" src="https://github.com/user-attachments/assets/f79e959e-6158-4b54-a00d-acb025c61dd6" />

