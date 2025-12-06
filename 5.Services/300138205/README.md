 # 300138205

 **Étudiant :** taylor  
**Cours :** INF1084-202-25A-04  

## 📋 Objectifs

- Lister les services AD et leur état
- Afficher les événements d'un service AD
- Capturer les événements d'un service AD dans un fichier
- Arrêt et redémarrage d'un service

## 📁 Scripts

1. `services1.ps1` - Lister tous les services liés à AD
2. `services2.ps1` - Afficher les événements des services AD
3. `services3.ps1` - Exporter les logs AD en CSV
4. `services4.ps1` - Arrêter et redémarrer un service

## 🚀 Exécution
services1.ps1
 ```powershell
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier l’état d’un service spécifique
Get-Service -Name NTDS, ADWS, DFSR
```

<details>
 

  ```powershell

Status   Name               DisplayName
------   ----               -----------
Running  NTDS               Active Directory Domain Services
Running  ADWS               Active Directory Web Services
Running  DFSR               DFS Replication
Running  IsmServ            Intersite Messaging
Running  Kdc                Kerberos Key Distribution Center
Running  Netlogon           Netlogon
Running  ADWS               Active Directory Web Services
Running  DFSR               DFS Replication
Running  NTDS               Active Directory Domain Services

```

</details>

services2.ps1
```powershell
# Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les logs du système
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Afficher les logs via le journal moderne (Event Viewer v2)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```

<details>

  ```powershell

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
     181 Nov 14 14:31  Information NTDS General           1073744851 Internal event: Online Defragment Start succeed...
     180 Nov 14 14:31  Information NTDS General           1073744857 Internal event: Online Defragment Stop invoked ...
     179 Nov 14 14:31  Information NTDS ISAM                     701 NTDS (848,D,0) NTDSA: Online defragmentation ha...
     178 Nov 14 14:31  Information NTDS ISAM                     700 NTDS (848,D,0) NTDSA: Online defragmentation is...
     177 Nov 14 14:16  Information NTDS General           1073742986 Internal event: The Address Book hierarchy tabl...
     176 Nov 14 14:16  Warning     NTDS General           2147486689 The security of this directory server can be si...
     175 Nov 14 02:31  Information NTDS General           1073744851 Internal event: Online Defragment Start succeed...
     174 Nov 14 02:31  Information NTDS General           1073744857 Internal event: Online Defragment Stop invoked ...
     173 Nov 14 02:31  Information NTDS ISAM                     701 NTDS (848,D,0) NTDSA: Online defragmentation ha...
     172 Nov 14 02:31  Information NTDS ISAM                     700 NTDS (848,D,0) NTDSA: Online defragmentation is...
     171 Nov 14 02:16  Information NTDS General           1073742986 Internal event: The Address Book hierarchy tabl...
     170 Nov 13 14:31  Information NTDS General           1073744851 Internal event: Online Defragment Start succeed...
     169 Nov 13 14:31  Information NTDS General           1073744857 Internal event: Online Defragment Stop invoked ...
     168 Nov 13 14:31  Information NTDS ISAM                     701 NTDS (848,D,0) NTDSA: Online defragmentation ha...
     167 Nov 13 14:31  Information NTDS ISAM                     700 NTDS (848,D,0) NTDSA: Online defragmentation is...
     166 Nov 13 14:16  Information NTDS General           1073742986 Internal event: The Address Book hierarchy tabl...
     165 Nov 13 14:16  Warning     NTDS General           2147486689 The security of this directory server can be si...
     164 Nov 13 02:31  Information NTDS General           1073744851 Internal event: Online Defragment Start succeed...
     163 Nov 13 02:31  Information NTDS General           1073744857 Internal event: Online Defragment Stop invoked ...
     162 Nov 13 02:31  Information NTDS ISAM                     701 NTDS (848,D,0) NTDSA: Online defragmentation ha...



TimeCreated             Id LevelDisplayName Message
-----------             -- ---------------- -------
11/14/2025 2:31:42 PM 3027 Information      Internal event: Online Defragment Start succeeded. ...
11/14/2025 2:31:42 PM 3033 Information      Internal event: Online Defragment Stop invoked but defrag was not running.
11/14/2025 2:31:42 PM  701 Information      NTDS (848,D,0) NTDSA: Online defragmentation has completed a full pass o...
11/14/2025 2:31:42 PM  700 Information      NTDS (848,D,0) NTDSA: Online defragmentation is beginning a full pass on...
11/14/2025 2:16:41 PM 1162 Information      Internal event: The Address Book hierarchy table has been rebuilt.
11/14/2025 2:16:41 PM 3041 Warning          The security of this directory server can be significantly enhanced by c...
11/14/2025 2:31:42 AM 3027 Information      Internal event: Online Defragment Start succeeded. ...
11/14/2025 2:31:42 AM 3033 Information      Internal event: Online Defragment Stop invoked but defrag was not running.
11/14/2025 2:31:42 AM  701 Information      NTDS (848,D,0) NTDSA: Online defragmentation has completed a full pass o...
11/14/2025 2:31:42 AM  700 Information      NTDS (848,D,0) NTDSA: Online defragmentation is beginning a full pass on...
11/14/2025 2:16:42 AM 1162 Information      Internal event: The Address Book hierarchy table has been rebuilt.
11/13/2025 2:31:43 PM 3027 Information      Internal event: Online Defragment Start succeeded. ...
11/13/2025 2:31:43 PM 3033 Information      Internal event: Online Defragment Stop invoked but defrag was not running.
11/13/2025 2:31:43 PM  701 Information      NTDS (848,D,0) NTDSA: Online defragmentation has completed a full pass o...
11/13/2025 2:31:43 PM  700 Information      NTDS (848,D,0) NTDSA: Online defragmentation is beginning a full pass on...
11/13/2025 2:16:43 PM 1162 Information      Internal event: The Address Book hierarchy table has been rebuilt.
11/13/2025 2:16:43 PM 3041 Warning          The security of this directory server can be significantly enhanced by c...
11/13/2025 2:31:44 AM 3027 Information      Internal event: Online Defragment Start succeeded. ...
11/13/2025 2:31:44 AM 3033 Information      Internal event: Online Defragment Stop invoked but defrag was not running.
11/13/2025 2:31:44 AM  701 Information      NTDS (848,D,0) NTDSA: Online defragmentation has completed a full pass o...



```

</details>

services3.ps1
```powershell
# Vérifie si le dossier C:\Logs existe, sinon le crée
$logPath = "C:\Logs"
if (-not (Test-Path $logPath)) {
    New-Item -ItemType Directory -Path $logPath -Force
}

# Exporte les 50 derniers événements dans un fichier CSV
Get-EventLog -LogName Application -Newest 50 | Export-Csv -Path "$logPath\ADLogs.csv" -NoTypeInformation
```

<details>

  ```powershell

Aucune sortie apres l'execution du script
```

</details>

services4.ps1
```powershell
Stop-Service -Name DFSR
(Get-Service -name DFSR).status
Start-Service -Name DFSR
```

<details>

  ```powershell

PS C:\Users\Administrator\Developer\INF1084-202-25A-04\5.Services\300138205> .\services4.ps1
Stopped

```

</details>
