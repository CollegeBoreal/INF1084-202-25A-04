#300141368
services1.ps1
```powershell
#Lister tous les services lies a AD
Get-Service | where-Object {
$_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|lsmServ"
} | Sort-Object DisplayName

#Verifier l'etat d'un service specifique
Get-Service -Name NTDS, ADWS, DFSR
```

<details>

```powershell 

Status Name                   DisplayName
-----  ----                    -------
Running NTDS                   Active Directory Domain Services 
Running ADWS                   Active Directory Web Services
Running DFSR                   DFS Replication
Running IsmServ                Intersite Messaging
Running Kdc                    Kerberos key Distribution Center
Running Netlogon               Netlogon
Running ADWS                   Active Directory Web Services 
Running DFSR                   DFS Replication
Running NTDS                   Active Directory Domain Services 

```

</details>
=======
 # 300138205

services1.ps1

 ```powershell

\# Lister tous les services liés à AD

Get-Service | Where-Object {

    $\_.DisplayName -like "\*Directory\*" -or $\_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"

} | Sort-Object DisplayName



\# Vérifier l’état d’un service spécifique

Get-Service -Name NTDS, ADWS, DFSR

```



services2.ps1

```powershell

#Afficher les 20 derniers evenements lies a NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

#Afficher les logs du systeme 
Get-EventLog -LogName "System" -Newest 20 | where-Object {$_.Source -eq "Netlogon"}

#Afficher les logs via le journal moderne (Event Viewer v2)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -Autosize 

<details>

Services3.ps1
```powershell
#verifier si le dossier C:\Logs existe, sinon le cree 
$logPath = "C:\Logs"
if (-not(Test-Path $logPath)) {
New-Item -ItemType Directory -Path $logPath -Force
}

#Exporte les 50 derniers evenements dans un fichier CSV
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
PS C:\Users\Administrator\Developer\INF1084-202-25A-04\5.Services\300141368>.\Services4.ps1
Stopped 
```
'
</details>
=======

\\# Afficher les 20 derniers événements liés à NTDS

Get-EventLog -LogName "Directory Service" -Newest 20



\\# Afficher les logs du système

Get-EventLog -LogName "System" -Newest 20 | Where-Object {$\\\_.Source -eq "Netlogon"}



\\# Afficher les logs via le journal moderne (Event Viewer v2)

Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize

```



<details>



  



services3.ps1

```powershell

\\# Vérifie si le dossier C:\\\\Logs existe, sinon le crée

$logPath = "C:\\\\Logs"

if (-not (Test-Path $logPath)) {

\&nbsp;   New-Item -ItemType Directory -Path $logPath -Force

}



\\# Exporte les 50 derniers événements dans un fichier CSV

Get-EventLog -LogName Application -Newest 50 | Export-Csv -Path "$logPath\\\\ADLogs.csv" -NoTypeInformation

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



PS C:\\Users\\Administrator\\Developer\\INF1084-202-25A-04\\5.Services\\300138205> .\\services4.ps1

Stopped



```



</details>



