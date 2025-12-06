#300147786
# Gestion des Services Active Directory avec PowerShell

Ce projet permet de **lister, surveiller, exporter et contrôler les services Active Directory (AD)** à l'aide de scripts PowerShell.

---

## 1. Liste des scripts

| Script | Fonction |
|--------|----------|
| `services1.ps1` | Lister tous les services liés à AD et vérifier l’état de services spécifiques |
| `services2.ps1` | Afficher les événements récents liés à AD et Netlogon |
| `services3.ps1` | Exporter les événements AD dans un fichier CSV |
| `services4.ps1` | Arrêter et redémarrer un service AD spécifique |

---

## 2. Détails des scripts

### 2.1 `services1.ps1` – Liste des services AD

```powershell
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l’état d’un service spécifique
Get-Service -Name NTDS, ADWS, DFSR   ```

5.Services/300147786/images/s1.PNG

###Services2.ps1
# Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les logs du système liés à Netlogon
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Afficher les logs via le journal moderne (Event Viewer v2)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize

<img width="1012" height="391" alt="s2" src="https://github.com/user-attachments/assets/1c6dbc4f-0ad2-4d39-a042-149e2f36bf81" />


###Services3.ps1
# Exporter les 50 derniers événements du service annuaire dans un fichier CSV
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation

<img width="772" height="85" alt="s3" src="https://github.com/user-attachments/assets/ed080892-3161-4228-b4a8-b96f6f17a88c" />


##Services4.ps1
# Arrêter le service DFSR
Stop-Service -Name DFSR

# Vérifier l’état du service
(Get-Service -Name DFSR).Status

# Redémarrer le service DFSR
Start-Service -Name DFSR

<img width="858" height="100" alt="s4" src="https://github.com/user-attachments/assets/830c1b11-7b66-4735-b364-198c57890b2d" />


