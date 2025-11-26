mon fichier Readme "300153747"
services1.ps1
```powershell
# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

# Vérifier 'état'un service spécifique
Get-Service -Name NTDS, ADWS, DFSR
```
<details>
  ```powershell
  PS C:\Users\Public\developper\INF1084-202-25A-04\5.Services\300153747> .\services1.ps1

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
 ```powershell
# Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les logs du système
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Afficher les logs via le journal moderne (Event Viewer v2)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
```
<details>
  service2.ps1
  ```powershell
  PS C:\Users\Public\developper\INF1084-202-25A-04\5.Services\300153747> .\services2.ps1

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
     552 Nov 18 06:44  Information NTDS General           1073744851 Internal event: Online Defragment Start succeed...
     551 Nov 18 06:44  Information NTDS General           1073744857 Internal event: Online Defragment Stop invoked ...
     550 Nov 18 06:44  Information NTDS ISAM                     701 NTDS (868,D,0) NTDSA: Online defragmentation ha...
     549 Nov 18 06:44  Information NTDS ISAM                     700 NTDS (868,D,0) NTDSA: Online defragmentation is...
     548 Nov 18 06:29  Information NTDS General           1073742986 Internal event: The Address Book hierarchy tabl...
     547 Nov 17 18:44  Information NTDS General           1073744851 Internal event: Online Defragment Start succeed...
     546 Nov 17 18:44  Information NTDS General           1073744857 Internal event: Online Defragment Stop invoked ...
     545 Nov 17 18:44  Information NTDS ISAM                     701 NTDS (868,D,0) NTDSA: Online defragmentation ha...
     544 Nov 17 18:44  Information NTDS ISAM                     700 NTDS (868,D,0) NTDSA: Online defragmentation is...
     543 Nov 17 18:29  Information NTDS General           1073742986 Internal event: The Address Book hierarchy tabl...
     542 Nov 17 18:29  Warning     NTDS General           2147486689 The security of this directory server can be si...
     541 Nov 17 06:44  Information NTDS General           1073744851 Internal event: Online Defragment Start succeed...
     540 Nov 17 06:44  Information NTDS General           1073744857 Internal event: Online Defragment Stop invoked ...
     539 Nov 17 06:44  Information NTDS ISAM                     701 NTDS (868,D,0) NTDSA: Online defragmentation ha...
     538 Nov 17 06:44  Information NTDS ISAM                     700 NTDS (868,D,0) NTDSA: Online defragmentation is...
     537 Nov 17 06:29  Information NTDS General           1073742986 Internal event: The Address Book hierarchy tabl...
     536 Nov 16 18:44  Information NTDS General           1073744851 Internal event: Online Defragment Start succeed...
     535 Nov 16 18:44  Information NTDS General           1073744857 Internal event: Online Defragment Stop invoked ...
     534 Nov 16 18:44  Information NTDS ISAM                     701 NTDS (868,D,0) NTDSA: Online defragmentation ha...
     533 Nov 16 18:44  Information NTDS ISAM                     700 NTDS (868,D,0) NTDSA: Online defragmentation is...



TimeCreated             Id LevelDisplayName Message
-----------             -- ---------------- -------
11/18/2025 6:44:08 AM 3027 Information      Internal event: Online Defragment Start succeeded. ...
11/18/2025 6:44:08 AM 3033 Information      Internal event: Online Defragment Stop invoked but defrag was not running.
11/18/2025 6:44:08 AM  701 Information      NTDS (868,D,0) NTDSA: Online defragmentation has completed a full pass o...
11/18/2025 6:44:08 AM  700 Information      NTDS (868,D,0) NTDSA: Online defragmentation is beginning a full pass on...
11/18/2025 6:29:08 AM 1162 Information      Internal event: The Address Book hierarchy table has been rebuilt.
11/17/2025 6:44:09 PM 3027 Information      Internal event: Online Defragment Start succeeded. ...
11/17/2025 6:44:09 PM 3033 Information      Internal event: Online Defragment Stop invoked but defrag was not running.
11/17/2025 6:44:09 PM  701 Information      NTDS (868,D,0) NTDSA: Online defragmentation has completed a full pass o...
11/17/2025 6:44:09 PM  700 Information      NTDS (868,D,0) NTDSA: Online defragmentation is beginning a full pass on...
11/17/2025 6:29:09 PM 1162 Information      Internal event: The Address Book hierarchy table has been rebuilt.
11/17/2025 6:29:08 PM 3041 Warning          The security of this directory server can be significantly enhanced by c...
11/17/2025 6:44:09 AM 3027 Information      Internal event: Online Defragment Start succeeded. ...
11/17/2025 6:44:09 AM 3033 Information      Internal event: Online Defragment Stop invoked but defrag was not running.
11/17/2025 6:44:09 AM  701 Information      NTDS (868,D,0) NTDSA: Online defragmentation has completed a full pass o...
11/17/2025 6:44:09 AM  700 Information      NTDS (868,D,0) NTDSA: Online defragmentation is beginning a full pass on...
11/17/2025 6:29:09 AM 1162 Information      Internal event: The Address Book hierarchy table has been rebuilt.
11/16/2025 6:44:10 PM 3027 Information      Internal event: Online Defragment Start succeeded. ...
11/16/2025 6:44:10 PM 3033 Information      Internal event: Online Defragment Stop invoked but defrag was not running.
11/16/2025 6:44:10 PM  701 Information      NTDS (868,D,0) NTDSA: Online defragmentation has completed a full pass o...
11/16/2025 6:44:10 PM  700 Information      NTDS (868,D,0) NTDSA: Online defragmentation is beginning a full pass on...

```
</details>
service3.ps1
```powershell
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation
```
services4.ps1
```powershell
Stop-Service -Name DFSR
(Get-Service -name DFSR).status
Start-Service -Name DFSR
```
<details>
  ```powershell
  
PS C:\Users\Public\developper\INF1084-202-25A-04\5.Services\300153747> .\services4.ps1
Stopped
```
</details>

