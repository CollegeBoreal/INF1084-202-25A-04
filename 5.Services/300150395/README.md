
--------------------------------------------------------------------------------------------------------------------------------------------------------

# Laboratoire : Services Windows et Active Directory (AD DS)
**Étudiant :** Ismail Trache  
**ID :** 300150395  

---

## Objectifs
- Identifier et vérifier les services Active Directory.  
- Consulter et exporter les journaux d'événements AD.  
- Arrêter et redémarrer un service AD critique (DFSR).  

---

## Scripts PowerShell

| Script | Fonction |
|:--|:--|

| `services1.ps1` | Lister les services AD et vérifier leur état |


```powershell
# services1.ps1 - Ismail Trache 300150395
# Objectif : Lister tous les services liés à Active Directory et vérifier leur état.

Write-Host "=== Liste des services Active Directory ===" -ForegroundColor Cyan

# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

Write-Host "`n=== État des services principaux ===" -ForegroundColor Cyan

# Vérifier l’état de certains services clés
Get-Service -Name NTDS, ADWS, DFSR, KDC, Netlogon, IsmServ | Format-Table Name, Status, DisplayName -AutoSize
```


| `services2.ps1` | Afficher les journaux Directory Service et Netlogon |


```powershell
# services2.ps1 - Ismail Trache 300150395
# Objectif : Afficher les événements récents liés à Active Directory.

Write-Host "=== Derniers événements Directory Service ===" -ForegroundColor Cyan

# 1. Afficher les 20 derniers événements du service Directory Service
Get-EventLog -LogName "Directory Service" -Newest 20

Write-Host "`n=== Derniers événements Netlogon (système) ===" -ForegroundColor Cyan

# 2. Afficher les 20 derniers logs système liés à Netlogon
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

Write-Host "`n=== Journaux modernes (Event Viewer v2) ===" -ForegroundColor Cyan

# 3. Afficher les 20 derniers événements Directory Service via le nouveau moteur de logs
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize

```

| `services3.ps1` | Exporter les logs Directory Service dans `C:\Logs\ADLogs.csv` |


```powershell
# services3.ps1 - Ismail Trache 300150395
# Objectif : Exporter les événements Directory Service dans un fichier CSV.

Write-Host "=== Export des journaux Directory Service vers C:\Logs\ADLogs.csv ===" -ForegroundColor Cyan

# Créer le dossier Logs s’il n’existe pas
if (!(Test-Path -Path "C:\Logs")) {
    New-Item -ItemType Directory -Path "C:\Logs" | Out-Null
}

# Exporter les 50 derniers événements Directory Service
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation

Write-Host "`nExport terminé avec succès !" -ForegroundColor Green

```


| `services4.ps1` | Arrêter et redémarrer le service DFSR |

```powershell
# services4.ps1 - Ismail Trache 300150395
# Objectif : Arrêter et redémarrer le service DFSR (Distributed File System Replication)

Write-Host "=== Vérification de l'état initial du service DFSR ===" -ForegroundColor Cyan
Get-Service -Name DFSR | Format-Table Name, Status -AutoSize

Write-Host "`n=== Arrêt du service DFSR... ===" -ForegroundColor Yellow
Stop-Service -Name DFSR
Start-Sleep -Seconds 3

Write-Host "`nÉtat après arrêt :" -ForegroundColor Cyan
Get-Service -Name DFSR | Format-Table Name, Status -AutoSize

Write-Host "`n=== Redémarrage du service DFSR... ===" -ForegroundColor Yellow
Start-Service -Name DFSR
Start-Sleep -Seconds 3

Write-Host "`nÉtat final :" -ForegroundColor Cyan
Get-Service -Name DFSR | Format-Table Name, Status -AutoSize

Write-Host "`nService DFSR redémarré avec succès !" -ForegroundColor Green

```


---

## Captures d’écran

1. Liste et état des services AD  
<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot 2025-10-28 204827.png" />


2. Journaux Directory Service (Event Viewer / PowerShell)  
<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot 2025-11-04 182339.png" />


3. Export des logs CSV dans `C:\Logs`  
<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot 2025-11-04 182737.png" />


4. Arrêt et redémarrage du service DFSR  
<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" src="images/Screenshot 2025-11-04 183025.png" />

---

## Observations

- Tous les services AD essentiels (`NTDS`, `ADWS`, `DFSR`, `KDC`, `Netlogon`, `IsmServ`) sont **en cours d’exécution**.  
- Les événements du journal `Directory Service` montrent des opérations de **défragmentation réussies (Event ID 3027, 700, 701)**, signe d’un service AD DS fonctionnel.  
- L’arrêt/redémarrage du service DFSR s’effectue **sans erreur**, prouvant la bonne configuration du domaine.  

---

## Conclusion
Ce laboratoire a permis de comprendre le rôle et la dépendance des principaux services d’Active Directory, ainsi que leur gestion via **PowerShell et l’Event Viewer**.
